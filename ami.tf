# A Terraform file to test the approved_ami.rego custom rule
# See our blog post for details: https://blog.fugue.co

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "good" {
  ami           = "ami-09e67e426f25ce0d7"
  instance_type = "t2.micro"
}

resource "aws_instance" "bad" {
  ami           = "ami-totallylegitamiid"
  instance_type = "t2.micro"
}