terraform {
  required_version = ">= 1.0.0, < 2.0.0"
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.48.1"
    }
  }
}

resource "proxmox_virtual_environment_container" "container" {
  description   = var.description
  start_on_boot = var.onboot
  node_name     = var.target_node
  memory {
    dedicated = var.memory
  }

  disk {
    datastore_id = var.storage_pool
    size         = var.disk_size
  }

  initialization {
    hostname = var.name

    ip_config {
      ipv4 {
        address = var.ip
        gateway = var.ip == "dhcp" ? null : var.gw
      }
    }

    user_account {
      keys     = var.ssh_keys
      password = var.root_password
    }
  }

  network_interface {
    name    = "eth0"
    vlan_id = var.vlan
    bridge  = var.bridge

  }

  operating_system {
    template_file_id = var.source_template
  }
}
