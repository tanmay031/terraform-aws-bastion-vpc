# modules/ec2/main.tf

variable "ami_id" {
  type = string
}

variable "public_subnet_id" {
  type = string
}

variable "private_subnet_id" {
  type = string
}

variable "key_name" {
  type = string
}

variable "bastion_sg_id" {
  type = string
}

variable "private_sg_id" {
  type = string
}

resource "aws_instance" "bastion" {
  ami                         = var.ami_id
  instance_type               = "t3.micro"
  subnet_id                   = var.public_subnet_id
  key_name                    = var.key_name
  vpc_security_group_ids      = [var.bastion_sg_id]
  associate_public_ip_address = true

  tags = {
    Name = "bastion-host"
  }
}

resource "aws_instance" "private" {
  ami                         = var.ami_id
  instance_type               = "t3.micro"
  subnet_id                   = var.private_subnet_id
  key_name                    = var.key_name
  vpc_security_group_ids      = [var.private_sg_id]
  associate_public_ip_address = false

  tags = {
    Name = "private-host"
  }
}

output "bastion_public_ip" {
  value = aws_instance.bastion.public_ip
}

output "private_instance_ip" {
  value = aws_instance.private.private_ip
}
