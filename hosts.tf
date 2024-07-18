/* Universal Links ------------------------------*/

module "uni_links" {
  source     = "github.com/status-im/infra-tf-multi-provider"

  name       = "node"
  env        = "uni-links"
  group      = "uni-links"

  do_count = 1
  ac_count = 0
  gc_count = 0

  open_tcp_ports = ["80", "443"]
}

resource "cloudflare_record" "join_status_im" {
  zone_id  = lookup(local.zones, "status.im")
  name     = "join"
  value    = module.uni_links.public_ips[0]
  type     = "A"
  proxied  = true
}
