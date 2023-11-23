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


module "proxmox_vm_1" {
  source         = "../../../modules/vm-module/"
  vm_name        = "Terraform-Example-VM1"
  target_node    = "ibm-x3200-prox1"
  clone_template = "${var.clone_template}-node1"
}

module "proxmox_vm_2" {
  source         = "../../../modules/vm-module/"
  vm_name        = "Terraform-Example-VM2"
  target_node    = "ibm-x3200-prox2"
  clone_template = "${var.clone_template}-node2"
}
