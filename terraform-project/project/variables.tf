variable "vpc_id" {
    type = string
    description = "hassan vpc"
    default = ""
} 

variable "vpc_cidr_block" {
    type = string
    default = "20.0.0.0/16"
}

variable "pub_subnet_cidr_block" {
    type = string
    default = "20.0.10.0/24"
}

variable "pri_subnet_cidr_block" {
    type = string
    default = "20.0.20.0/24"
}


variable "out_cidr_block" {
    type = string
    default = "0.0.0.0/0"
}

variable "ubuntu_ami" {
    type = string
    default = "ami-014d05e6b24240371"
}

variable "instance_type_ec2" {
    type = string
    default = "t2.micro"
}


variable "access_key_id" {
  type = string
  default = "AKIAW5TLSF2V6OHX3FX2"
}

variable "secret_key" {
  type = string
  default = "39D66BNAdBkkN/XVVLZVD8UbgYG6pm7rkJ/ongBg"
}

variable "sg_protocol" {
  type = string
  default = "tcp"
}

variable "region" {
    type = string
    default = "us-west-1"
}

variable "zone_dispo" {
    type = string
    default ="a"  
}
variable "subnet_id" {
    type = string
    description = "hassan subnet"
    default = ""
}
variable "hassan_sg_public" {
    type = string
    description = "hassan subnet public"
    default = ""
}
variable "hassan_sg_private" {
    type = string
    description = "hassan subnet private"
    default = ""
}


