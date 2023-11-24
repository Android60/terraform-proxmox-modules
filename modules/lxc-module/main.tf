terraform {
  required_version = ">= 1.0.0, < 2.0.0"
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "2.9.10"
    }
  }
}

resource "proxmox_lxc" "webservers-lxc" {
  hostname    = var.name
  password    = var.root_password
  description = var.description
  target_node = each.value.target_node
  memory      = each.value.memory
  cores       = each.value.vcpu
  ostemplate  = var.source_template
  start       = true
  onboot      = true
  nameserver  = var.nameserver
  rootfs {
    size    = var.disk_size
    storage = var.storage_pool
  }
  network {
    name   = "eth0"
    bridge = var.bridge
    tag    = var.vlan
    ip     = var.ip
    gw     = var.ip == "dhcp" ? null : var.gw
  }

  ssh_public_keys = var.ssh_keys
}
