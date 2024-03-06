terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.48.1"
    }
  }
}

provider "proxmox" {
}


module "lxc_ct" {
  source          = "../../../modules/lxc-module"
  name            = var.lxc_name
  root_password   = var.root_password
  target_node     = var.target_node
  source_template = var.source_template
  onboot          = true
}
