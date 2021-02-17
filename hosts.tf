/* Universal Links ------------------------------*/

module "uni_links" {
  source     = "github.com/status-im/infra-tf-multi-provider"
  host_count = var.uni_links_hosts
  name       = "node"
  env        = "uni-links"
  group      = "uni-links"
  domain     = var.domain

  open_tcp_ports = ["80", "443"]
}

/* Load Blanacer for created hosts */
module "uni_links_lb" {
  source = "./modules/cloud-flare-lb"
  env    = "uni-links"
  name   = "join"
  hosts  = module.uni_links.hosts_by_dc
  domain = var.public_domain
}
