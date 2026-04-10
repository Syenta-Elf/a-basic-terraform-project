output "nginx_url" {
  value = "http://localhost:${docker_container.containers["nginx"].ports[0].external}"
}

# Network adı — başka modül bu network'e container ekleyecekse
output "private_network_name" {
  value = docker_network.private_network.name
}

# Container ID'leri — CI/CD'de health check için
output "container_ids" {
  value = {
    for k, v in docker_container.containers : k => v.id 
  }
}

output "container_ips" {
  value = {
    for k, v in docker_container.containers : k => v.network_data[0].ip_address
  }
}