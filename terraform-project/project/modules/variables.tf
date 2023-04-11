variable "vpc_id" {
    type = string
    description = "hassan vpc"
}
variable "gateway_id" {
    type = string
    description = "hassan igw" 
}
variable "is_public" {
    type = bool
    default = true
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
variable "subnet_id" {
    type = string
    description = "hassan subnet"
    default = ""
}
variable "ubuntu_ami" {
    type = string
    default = "ami-014d05e6b24240371"
}

variable "instance_type_ec2" {
    type = string
    default = "t2.micro"
}
variable "hassan_sg_public" {
    type = string
    description = "hassan sg public"
    default = ""  
}
variable "hassan_sg_private" {
    type = string
    description = "hassan sg private"
    default = ""  
}

variable "region" {
    type = string
}

variable "zone_dispo" {
    type = string   
}

variable "commands" {
  type = list
}

variable "key" {
    type = string
    default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDEU9Xhe1n8xIqtus4qS+SCzt02x2V/K7tIlnjYjDC8uh5P6fQFJEogu0u4TZFKT/a/TNSNXWgAKyHNuakjF5ZZzvualVsDaiPs8yd7WY06zKFG2uxcJJ5HZKuhHtyZLUDrFVYMRTkLwUModihKEjQxzg7FkUs2YLMtZaGa1B5j3QyMUoakgx1jg+Sms9jR4IHo/rGDFwvReKYjv4FIVAn56o/mQlHHtVFmc04pymXjsCDhqDFNuGYglCQek9g9dQnWhmlEpZqfA9v3U02LM2cr5ZsChTMkPvKtG7jqKHclNOn353HX3PiwfbAV2CPFE6gDK6lVqHhYb77jPCyi8FOKmEjvB8fMgyf++SkPh7CF61Y5al8+6LPOMXE+rupfXHuBgaCTbtp4YNhjwqnATRWjYeLkaCOei/UV78HoBgYKWdfe7FUz89YLIl12FEqEXfomE3fL1ixmlGCHiJeogIdjKyViBbYdmAJXqVqfc3MFoB7mXWngP8UTpGxxWHVidLTNsMTN4ztqVEslBsq7GGpwqxeIBtb0HRkKafUwiXAMHwwOwISgs+fqX6koVQEvFE92kNc5Sx/w9KXRl+Vk1b1GsQBzoP0P0SSQrt2qyCZq3gslapynZHo8Lf/eXsotEe84OWgzV8UiTAtjiYmWwCKaz5dFU4PzDr2xO7dV6OMyyQ== hassan@MyT14"
  
}