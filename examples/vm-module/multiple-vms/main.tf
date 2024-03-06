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


module "proxmox_vm_1" {
  source         = "../../../modules/vm-module/"
  name           = "Terraform-Example-VM1"
  target_node    = var.target_node
  clone_template = var.clone_template
}

module "proxmox_vm_2" {
  source         = "../../../modules/vm-module/"
  name           = "Terraform-Example-VM2"
  target_node    = var.target_node
  clone_template = var.clone_template
}
