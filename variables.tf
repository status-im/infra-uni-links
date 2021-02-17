/* GENERAL --------------------------------------*/

variable "public_domain" {
  description = "Domain under which the public sites go."
  default     = "status.im"
}

variable "domain" {
  description = "DNS Domain to update"
  default     = "statusim.net"
}

/* SCALING --------------------------------------*/

variable "uni_links_hosts" {
  description = "Number of hosts to use for universal Status links."
  default     = 1
}
