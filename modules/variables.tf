variable "image" {
  type        = map(map(string))
  description = "image for container"
  default = {
    nodered = {
      dev  = "nodered/node-red:latest"
      prod = "nodered/node-red:latest-minimal"
    }
    influxdb = {
      dev  = "quay.io/influxdb/influxdb:v2.0.2"
      prod = "quay.io/influxdb/influxdb:v2.0.2"
    }
    grafana = {
      dev  = "grafana/grafana-oss:latest"
      prod = "grafana/grafana-enterprise:latest"
    }
  }
}

variable "ext_port" {
  type = map(map(list(number)))
}
