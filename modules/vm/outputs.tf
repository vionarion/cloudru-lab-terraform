output "id" {
  value = cloudru_evolution_compute_vm.this.id
}

output "private_ip" {
  value = cloudru_evolution_compute_interface.this.ip_address
}

output "public_ip" {
  value = var.public_ip ? cloudru_evolution_compute_external_ip.this[0].ip_address : null
}
