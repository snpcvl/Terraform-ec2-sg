provider "aws"{
    region = "ap-southeast-1"
    access_key = "AKIATMDDPQDWVARU2MYT"
    secret_key = "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"
}
resource "aws_instance" "terraform_wapp" {
  ami                         = "ami-0ed9277fb7eb570c9"
  instance_type               = "t2.micro"
  vpc_security_group_ids      = ["${aws_security_group.terraform_private_sg.id}"]
  subnet_id                   = aws_subnet.terraform-subnet_1.id
  count                       = 1
  associate_public_ip_address = true
  tags = {
    Name        = "terraform_ec2_wapp_awsdev"
    Environment = "development"
    Project     = "DEMO-TERRAFORM"
  }
}
resource "aws_vpc" "terraform-vpc" {
  cidr_block           = var.cidr
  enable_dns_hostnames = true
  tags = {
    Name = "terraform-demo-vpc"
  }
}
resource "aws_security_group" "terraform_private_sg" {
  description = "Allow limited inbound external traffic"
  vpc_id      = aws_vpc.terraform-vpc.id
  name        = "terraform_ec2_private_sg"

  ingress {
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
  }

  ingress {
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 8080
    to_port     = 8080
  }

  ingress {
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 443
    to_port     = 443
  }

  egress {
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
  }

  tags = {
    Name = "ec2-private-sg"
  }
}
resource "aws_subnet" "terraform-subnet_1" {
  vpc_id            = aws_vpc.terraform-vpc.id
  cidr_block        = var.subnet
  availability_zone = "ap-southeast-1a"

  tags = {
    Name = "terraform-subnet_1"
  }
}
