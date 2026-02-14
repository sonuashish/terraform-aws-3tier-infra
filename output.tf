output "server_public_ips" {
  value = module.compute.public_ip
}

output "server_private_ips" {
  value = module.compute.private_ip
}
