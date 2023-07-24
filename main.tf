terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
    }
  }
}
provider "aws" {
  profile = "default"
  region = "ap-south-1"
}

resource "aws_vpc" "apihitvpc" {    
    cidr_block = "10.0.0.0/16"
    tags = {
      "Name" = "apihit"
    }
}
resource "aws_subnet" "apihitpub" {
  cidr_block = "10.0.0.0/24"
  vpc_id = aws_vpc.apihitvpc.id
  availability_zone = "ap-south-1a"
  tags = {
    "Name" = "apihit"
  }
}
resource "aws_internet_gateway" "apihitig" {
  vpc_id = aws_vpc.apihitvpc.id
  tags = {
    "Name" = "fithealth2ig"
  }
}
resource "aws_route_table" "apihitrt" {
    vpc_id = aws_vpc.apihitvpc.id
    route {
        gateway_id = aws_internet_gateway.apihitig.id
        cidr_block = "0.0.0.0/0"
    }
    tags = {
      "Name" = "fithealth2igrt"
    }
}
resource "aws_route_table_association" "apihitassocitation" {
  route_table_id = aws_route_table.apihitrt.id
  subnet_id = aws_subnet.apihitpub.id
}
resource "aws_security_group" "allopen" {
  vpc_id = aws_vpc.apihitvpc.id
  ingress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_instance" "apihitserver" {
  subnet_id = aws_subnet.apihitpub.id
  associate_public_ip_address = true
  instance_type = "t2.micro"
  ami = "ami-0f5ee92e2d63afc18"
  vpc_security_group_ids = [aws_security_group.allopen.id]
  tags = {
    Name = "MyEC2Instance"
   }

 

  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install -y docker.io
              sudo systemctl start docker
              sudo systemctl enable docker
              sudo docker run -d -p 80:5000 sparshericsson/ubuntu:2.0
              EOF
}





















