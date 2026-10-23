output "subnet_id" {
  description = "Subnet ID."
  value       = cloudru_evolution_compute_subnet.this.id
}

output "security_group_id" {
  description = "Security group ID."
  value       = cloudru_evolution_compute_security_group.this.id
}
