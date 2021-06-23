terraform {
  required_version = "~> 1.0.0"
  required_providers {
    pass = {
      source  = "camptocamp/pass"
      version = " = 2.0.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = " = 2.21.0"
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
