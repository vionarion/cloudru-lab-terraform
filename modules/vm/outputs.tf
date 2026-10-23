output "id" {
  description = "VM ID."
  value       = cloudru_evolution_compute_vm.this.id
}

output "private_ip" {
  description = "Private IP of the VM."
  value       = cloudru_evolution_compute_interface.this.ip_address
}

output "public_ip" {
  description = "Public IP, if any."
  value       = var.public_ip ? cloudru_evolution_compute_external_ip.this[0].ip_address : null
}
