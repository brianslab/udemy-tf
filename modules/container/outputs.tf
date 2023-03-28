output "container-name" {
  value       = docker_container.nodered_container.name
  description = "The names of the containers"
}

output "ip-address" {
  value       = [for i in docker_container.nodered_container[*] : join(":", [i.ip_address], i.ports[*]["external"])]
  description = "The IP addresses and external port of the containers"
}

