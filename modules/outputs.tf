output "container-name" {
  value       = module.container[*].container-name
  description = "The names of the containers"
}

output "IP-Address" {
  value       = flatten(module.container[*].ip-address)
  description = "The IP addresses and external port of the containers"
}
