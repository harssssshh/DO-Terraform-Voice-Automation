terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "1.22.2"
    }
  }
}

variable "do_pat" {}
#variable "region" {}
provider "digitalocean" {
  token = var.do_pat
}

