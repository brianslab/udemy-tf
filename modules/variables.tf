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
  }
}

variable "ext_port" {
  type = map(map(list(number)))

  # validation {
  #   condition     = max(var.ext_port["dev"]...) <= 65535 && min(var.ext_port["dev"]...) >= 1980
  #   error_message = "The external port must be between 0 and 65535."
  # }
  # validation {
  #   condition     = max(var.ext_port["prod"]...) < 1980 && min(var.ext_port["prod"]...) >= 1880
  #   error_message = "The external port must be between 0 and 65535."
  # }
}

# variable "int_port" {
#   type    = number
#   default = 1880

#   validation {
#     condition     = var.int_port == 1880
#     error_message = "The internal port must be 1880."
#   }
# }

# locals {
#   container_count = length(var.ext_port[terraform.workspace])
# }
