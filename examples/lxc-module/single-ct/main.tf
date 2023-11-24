terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "2.9.10"
    }
  }
}

provider "proxmox" {
  pm_tls_insecure = true
  pm_timeout      = 900
}


module "lxc_ct" {
  source          = "../../../modules/lxc-module"
  name            = var.lxc_name
  root_password   = var.root_password
  target_node     = var.target_node
  source_template = var.source_template
}
