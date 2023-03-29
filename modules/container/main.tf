resource "random_string" "random" {
  length  = 4
  special = false
  count   = var.count_in
}

resource "docker_container" "app_container" {
  name  = join("-", [var.name_in, terraform.workspace, random_string.random[count.index].result])
  image = var.image_in
  count = var.count_in
  ports {
    internal = var.int_port_in
    external = var.ext_port_in[count.index]
  }
  volumes {
    container_path = var.container_path_in
    volume_name    = docker_volume.container_volume[count.index].name
  }
}

resource "docker_volume" "container_volume" {
  name  = "${var.name_in}-${random_string.random[count.index].result}-volume"
  count = var.count_in
  lifecycle {
    prevent_destroy = false
  }
}
