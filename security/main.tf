# modules/security/main.tf

variable "vpc_id" {
  type = string
}

variable "bastion_sg_name" {
  type = string
}

variable "private_sg_name" {
  type = string
}

resource "aws_security_group" "bastion_sg" {
  name        = var.bastion_sg_name
  description = "Allow SSH from anywhere"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.bastion_sg_name
  }
}

resource "aws_security_group" "private_sg" {
  name        = var.private_sg_name
  description = "Allow SSH from bastion only"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.1.0/24"] # Public subnet CIDR
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.private_sg_name
  }
}

output "bastion_sg_id" {
  value = aws_security_group.bastion_sg.id
}

output "private_sg_id" {
  value = aws_security_group.private_sg.id
}
