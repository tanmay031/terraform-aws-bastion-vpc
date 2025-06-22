# variables.tf

variable "region" {
  type    = string
  default = "eu-north-1"
}

variable "profile" {
  type    = string
  default = "prahman"
}

variable "ami_id" {
  type    = string
  description = "Ubuntu AMI ID for the region"
  default = "ami-0914547665e6a707c"
}

variable "key_name" {
  type    = string
  default = "terraform-bastion-key"
}
