output "ip_address" {
  value       = proxmox_virtual_environment_vm.vm.ipv4_addresses[1]
  description = "IP address of VM"
}

output "vmid" {
  value       = proxmox_virtual_environment_vm.vm.vm_id
  description = "VM ID"
}
