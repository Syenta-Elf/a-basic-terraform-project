resource "docker_network" "private_network" {
  name       = "private_network"
  attachable = true
}

resource "docker_image" "images" {
  for_each = var.image_list
  name     = "${each.key}:${each.value.tag}"
}

resource "docker_container" "containers" {
  for_each = var.image_list
  name     = each.key
  image    = docker_image.images[each.key].image_id

  dynamic "ports" {
    for_each = each.value.target_port != null ? [1] : []
    content {
      internal = each.value.target_port
      external = each.value.external_port != null ? each.value.external_port : each.value.target_port
    }
  }
  networks_advanced {
    name = docker_network.private_network.name
  }
  env = each.value.env
}