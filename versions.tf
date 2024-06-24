terraform {
  required_version = "> 1.4.0"
  required_providers {
    pass = {
      source  = "camptocamp/pass"
      version = " = 2.1.1"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = " = 3.26.0"
    }
    alicloud = {
      source = "aliyun/alicloud"
    }
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
    google = {
      source = "hashicorp/google"
    }
  }
}
