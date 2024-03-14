/* Universal Links ------------------------------*/

module "uni_links" {
  source     = "github.com/status-im/infra-tf-multi-provider"

  host_count = var.uni_links_hosts
  name       = "node"
  env        = "uni-links"
  group      = "uni-links"

  open_tcp_ports = ["80", "443"]
}

/* Load Blanacer for created hosts */
module "uni_links_lb" {
  source     = "github.com/status-im/infra-tf-cloud-flare-lb"

  name   = "join"
  domain = "status.im"
  hosts  = module.uni_links.hosts_by_dc

  /* Required to map our DCs to pool regions. */
  region_map = tomap({
    "gc-us-central1-a" = "ENAM" /* Eastern North America */
    "ac-cn-hongkong-c" = "SEAS" /* Southeast Asia */
    "do-eu-amsterdam3" = "EEU" /* Eastern Europe */
  })

  account_id = data.pass_password.cloudflare_account.password
}
