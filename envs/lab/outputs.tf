output "bastion_ip" {
  description = "Public IP of the bastion node."
  value       = one([for k, vm in module.vm : vm.public_ip if vm.public_ip != null])
}

output "private_ips" {
  description = "Private IPs by node."
  value       = { for k, vm in module.vm : k => vm.private_ip }
}

output "ssh_config" {
  description = "Paste into ~/.ssh/config."
  value = join("\n", concat(
    [for k, vm in module.vm : "Host ${k}\n  HostName ${vm.public_ip}\n  User claude\n" if vm.public_ip != null],
    [for k, vm in module.vm : "Host ${k}\n  HostName ${vm.private_ip}\n  User claude\n  ProxyJump ${one([for b, v in module.vm : b if v.public_ip != null])}\n" if vm.public_ip == null],
  ))
}
