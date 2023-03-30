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
  dynamic "volumes" {
    for_each = var.volumes_in
    content {
      container_path = volumes.value["container_path_each"]
      volume_name    = docker_volume.container_volume[volumes.key].name
    }
  }
  provisioner "local-exec" {
    when    = create
    command = "echo ${self.name}: ${self.ip_address}:${var.ext_port_in[count.index]} >> containers.txt"
  }
  provisioner "local-exec" {
    when    = destroy
    command = "rm -f containers.txt"
  }
}

resource "docker_volume" "container_volume" {
  name  = "${var.name_in}-${count.index}-volume"
  count = length(var.volumes_in)
  lifecycle {
    prevent_destroy = false
  }
  provisioner "local-exec" {
    when       = destroy
    command    = "mkdir ~/Backups/docker/"
    on_failure = continue
  }
  provisioner "local-exec" {
    when       = destroy
    command    = "sudo tar -czvf ~/Backups/docker/${self.name}.tar.gz ${self.mountpoint}"
    on_failure = fail
  }
}
