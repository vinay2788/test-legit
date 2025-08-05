resource "aws_instance" "web_server" {
  ami                    = "ami-0f58b397bc5c1f2e8" # Replace with your desired AMI
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.my_subnet.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  key_name               = "vinay-legitbytes" # Replace with your existing key pair

  tags = {
    Name = "my-web-server"
  }
}
