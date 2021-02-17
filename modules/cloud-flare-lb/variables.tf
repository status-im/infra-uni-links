variable "zone_id" {
  description = "ID of CloudFlare zone for host record."
  /* We default to: status.net */
  default     = "fd48f427e99bbe1b52105351260690d1"
}

variable "env" {
  description = "Name of environment"
  type        = string
}

variable "stage" {
  description = "Stage of environment"
  type        = string
}

variable "name" {
  description = "Name of load balancer"
  type        = string
}

variable "domain" {
  description = "Name of domain to use"
  type        = string
}

variable "hosts" {
  description = "List of hosts to add"
  type        = map(map(string))
}
