terraform {
  required_version = ">= 1.0.0, < 2.0.0"
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.48.1"
    }
  }
}

# VM resource without provisioner
resource "proxmox_virtual_environment_vm" "vm" {
  name        = var.name
  description = var.description
  tags        = ["terraform", "ubuntu"]
  node_name   = var.target_node
  on_boot     = var.onboot
  cpu {
    cores   = var.cores
    sockets = var.sockets
    type    = var.cpu_type
  }
  memory {
    dedicated = var.memory
  }
  scsi_hardware = var.scsi_controller_type
  clone {
    datastore_id = var.storage_pool
    vm_id        = var.clone_template
    full         = true
  }

  agent {
    # read 'Qemu guest agent' section, change to true only when ready
    enabled = true
  }

  disk {
    datastore_id = var.storage_pool
    interface    = "scsi0"
    size         = var.disk_size
  }

  initialization {
    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }
    dns {
      servers = var.nameserver
    }
    user_account {
      keys     = var.ssh_keys
      username = var.user
      password = var.password
    }

    # Conflicts with user_account
    # user_data_file_id = "local:snippets/vendor.yaml"
  }

  network_device {
    bridge  = var.bridge
    vlan_id = var.vlan
  }

  operating_system {
    type = "l26"
  }

  serial_device {}
}
