resource "aws_instance" "web" {
  ami                         = var.image_id
  instance_type               = var.instancetype
  key_name                    = "viz_plat_key"
  associate_public_ip_address = true
  security_groups             = [aws_security_group.sg.id]
  subnet_id                   = aws_subnet.main.id
  availability_zone           = "ap-south-1a" 

  tags = {
    name = "web"
  }
}

resource "aws_vpc" "main" {
  cidr_block = "192.168.0.0/16"
}

resource "aws_security_group" "sg" {
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 0
    to_port          = 0
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.main.cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

resource "aws_subnet" "main" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "192.168.1.0/24"
  availability_zone = "ap-south-1a"
}

resource "aws_ebs_volume" "example" {
  availability_zone = "ap-south-1a"
  size              = 20

  tags = {
    Name = "HelloWorld"
  }
}