provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "example" {
  ami           = "ami-04aa685cc800320b3"
  instance_type = "t2.micro"
}
