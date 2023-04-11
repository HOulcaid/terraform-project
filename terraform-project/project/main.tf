// create VPC
resource "aws_vpc" "hassan_vpc" {
  cidr_block = var.vpc_cidr_block
  enable_dns_hostnames = "true"
  tags = {
    "Name" = "hassan_vpc"
  }
}

// create gateway
resource "aws_internet_gateway" "hassan_igw" {
  tags = {
    "Name" = "hassan_gateway"
  }
} 

// internet gateway attachment
resource "aws_internet_gateway_attachment" "igw_attachment" {
  internet_gateway_id = aws_internet_gateway.hassan_igw.id
  vpc_id              = aws_vpc.hassan_vpc.id
}

// module subnet
module "public" {
  source             = "./modules"
  region = var.region
  zone_dispo = var.zone_dispo
  is_public          = true
  vpc_id             = aws_vpc.hassan_vpc.id
  gateway_id         = aws_internet_gateway.hassan_igw.id
  commands = [ "sudo apt update -y",
               "sudo apt install docker.io -y",
               "sudo apt-get install ca-certificates curl gnupg -y",
               "sudo mkdir terraform",
               "cd terraform",
               "sudo git clone https://github.com/raoufcherfa/Imad-aws",
               "cd Imad-aws/angular",
               "sudo docker build -t appweb .",
               "sudo docker run -d -p 4200:80 appweb"
    ]
}
 module "private" {
  source             = "./modules"
  is_public          = false
  vpc_id             = aws_vpc.hassan_vpc.id
  gateway_id         = aws_internet_gateway.hassan_igw.id
  region = var.region
  zone_dispo = var.zone_dispo
  commands = [ "sudo apt update -y",
               "sudo apt install docker.io -y",
               "sudo apt-get install ca-certificates curl gnupg -y",
               "sudo mkdir terraform",
               "cd terraform",
               "sudo git clone https://github.com/raoufcherfa/employe",
               "cd employe",
               "sudo docker build -t back .",
               "sudo docker run -d -p 8080:8080 back"
    ]
}


