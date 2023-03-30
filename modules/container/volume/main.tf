resource "docker_volume" "container_volume" {
  name  = "${var.volume_name}-${count.index}"
  count = var.volume_count
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
