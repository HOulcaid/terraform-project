// create EC2 instance
resource "aws_instance" "hassan_app_front" {
  count = var.is_public ? 1 : 0
  ami = var.ubuntu_ami
  instance_type = var.instance_type_ec2
  subnet_id = aws_subnet.hassan_subnet_public[count.index].id
  vpc_security_group_ids = [aws_security_group.hassan_sg_public[count.index].id]
  associate_public_ip_address = var.is_public
  key_name = "hassan_key"

  connection {
   type        = "ssh"
   host        = self.public_ip
   user        = "ubuntu"
   private_key = file("./hassan_key.pem")
   timeout     = "4m"
 }

    provisioner "remote-exec" {
    inline = var.commands
  }

  tags = {
    "Name" = "hassan_EC2_frontend"
  }
}

// Key pair association
/*  resource "aws_key_pair" "deployer" {
  key_name   = "hassan_key"
  public_key = [var.key]
} */

/* output "ip_public" {
    value = aws_instance.hassan_EC2_frontend[*].ip_public  
} */

// create EC2 Backend
resource "aws_instance" "hassan_app_back" {
  count = !var.is_public ? 1 : 0
  ami = var.ubuntu_ami
  instance_type = var.instance_type_ec2
  subnet_id = aws_subnet.hassan_subnet_private[count.index].id
  vpc_security_group_ids = [aws_security_group.hassan_sg_private[count.index].id]
  key_name = "hassan_key" 

  associate_public_ip_address = var.is_public

  connection {
   type        = "ssh"
   host        = self.public_ip
   user        = "ubuntu"
   private_key = file("./hassan_key.pem")
   timeout     = "4m"
  }

// Error with var.commands in app_back: host for provisioner cannot be empty
/*
    provisioner "remote-exec" {
    inline = var.commands
  } */


    provisioner "remote-exec" {
    inline = [ "sudo apt update -y",
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
  
  tags = {
    "Name" = "hassan_EC2_backend"
  }

}