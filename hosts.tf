/* Universal Links ------------------------------*/

module "uni_links" {
  source     = "github.com/status-im/infra-tf-multi-provider"

  host_count = var.uni_links_hosts
  name       = "node"
  env        = "uni-links"
  group      = "uni-links"

  open_tcp_ports = ["80", "443"]
}

resource "cloudflare_record" "join_status_im" {
  zone_id  = lookup(local.zones, "status.im")
  for_each = toset(module.uni_links.public_ips)
  name     = "join"
  value    = each.value
  type     = "A"
  proxied  = true
}
