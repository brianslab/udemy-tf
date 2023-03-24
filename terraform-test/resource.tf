provider "aws" {

}

variable "AWS_REGION" {
  type    = string
  default = "us-west-2"
}

variable "AMIS" {
  type = map(string)
  default = {
    us-west-2 = "my ami"
  }
}

resource "aws_instance" "example" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"
}
