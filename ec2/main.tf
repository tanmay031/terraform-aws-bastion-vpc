# modules/ec2/main.tf

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

