/* https://support.cloudflare.com/hc/en-us/requests/1543877 */
resource "cloudflare_load_balancer_monitor" "health" {
  description    = "Basic /health check"
  expected_codes = "2xx"
  expected_body  = "OK"
  method         = "GET"
  type           = "https"
  path           = "/health"
  interval       = 60
  retries        = 5
  timeout        = 7

  /* disables SSl cert check, this way we can use origin */
  allow_insecure = true
}

/* https://github.com/terraform-providers/terraform-provider-cloudflare/issues/54 */
resource "cloudflare_load_balancer_pool" "do-eu-amsterdam3" {
  name               = "do-eu-amsterdam3.${var.env}.${terraform.workspace}"
  monitor            = cloudflare_load_balancer_monitor.health.id
  notification_email = "jakub@status.im"
  minimum_origins    = 1
  enabled            = true

  dynamic "origins" {
    iterator = host
    for_each = var.hosts["do-eu-amsterdam3"]
    content {
      name    = host.key
      address = host.value
    }
  }
}

resource "cloudflare_load_balancer_pool" "gc-us-central1-a" {
  name               = "gc-us-central1-a.${var.env}.${terraform.workspace}"
  monitor            = cloudflare_load_balancer_monitor.health.id
  notification_email = "jakub@status.im"
  minimum_origins    = 1
  enabled            = true

  dynamic "origins" {
    iterator = host
    for_each = var.hosts["gc-us-central1-a"]
    content {
      name    = host.key
      address = host.value
    }
  }
}

resource "cloudflare_load_balancer_pool" "ac-cn-hongkong-c" {
  name               = "ac-cn-hongkong-c.${var.env}.${terraform.workspace}"
  monitor            = cloudflare_load_balancer_monitor.health.id
  notification_email = "jakub@status.im"
  minimum_origins    = 1
  enabled            = true

  dynamic "origins" {
    iterator = host
    for_each = var.hosts["ac-cn-hongkong-c"]
    content {
      name    = host.key
      address = host.value
    }
  }
}

/* This might work, not sure yet */
resource "cloudflare_load_balancer" "main" {
  description      = "Load balancing of universal-links-handler service."

  zone_id = var.zone_id
  name    = "${var.name}.${var.domain}"
  proxied = true

  fallback_pool_id = cloudflare_load_balancer_pool.do-eu-amsterdam3.id
  default_pool_ids = [
    cloudflare_load_balancer_pool.do-eu-amsterdam3.id,
    cloudflare_load_balancer_pool.gc-us-central1-a.id,
    cloudflare_load_balancer_pool.ac-cn-hongkong-c.id,
  ]

  /**
   * This is Geo-Steering, for more details read:
   * https://support.cloudflare.com/hc/en-us/articles/115000540888-Load-Balancing-Geographic-Regions
   **/
  region_pools {
    region   = "EEU" /* Eastern Europe */
    pool_ids = [cloudflare_load_balancer_pool.do-eu-amsterdam3.id]
  }
  region_pools {
    region   = "ENAM" /* Eastern North America */
    pool_ids = [cloudflare_load_balancer_pool.gc-us-central1-a.id]
  }
  region_pools {
    region   = "SEAS" /* Southeast Asia */
    pool_ids = [cloudflare_load_balancer_pool.ac-cn-hongkong-c.id]
  }
}

