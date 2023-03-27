variable "env" {
  type        = string
  description = "Env to deploy to"
  default     = "dev"
}

variable "image" {
  type        = map(string)
  description = "image for container"
  default = {
    dev  = "nodered/node-red:latest"
    prod = "nodered/node-red:latest-minimal"
  }
}

variable "ext_port" {
  type = map(list(number))

  # validation {
  #   condition     = max(var.ext_port...) <= 65535 && min(var.ext_port...) > 0
  #   error_message = "The external port must be between 0 and 65535."
  # }
}

variable "int_port" {
  type    = number
  default = 1880

  validation {
    condition     = var.int_port == 1880
    error_message = "The internal port must be 1880."
  }
}

locals {
  container_count = length(lookup(var.ext_port, var.env))
}
