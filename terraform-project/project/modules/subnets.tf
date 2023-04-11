// create public subnet
resource "aws_subnet" "hassan_subnet_public" {
    count = var.is_public ? 1 : 0
    availability_zone = format("%s%s", var.region, var.zone_dispo)
    cidr_block =  var.pub_subnet_cidr_block
    vpc_id = var.vpc_id
  
  tags = {
    "Name" = "hassan_public_subnet"
  }
}

// create private subnet
resource "aws_subnet" "hassan_subnet_private" {
    count = !var.is_public ? 1 : 0
    availability_zone = format("%s%s", var.region, var.zone_dispo)
    cidr_block =  var.pri_subnet_cidr_block
    vpc_id = var.vpc_id
  
  tags = {
    "Name" = "hassan_private_subnet"
  }
}

// create public route table
resource "aws_route_table" "hassan_route_table_public" {
  count = var.is_public ? 1 : 0
  vpc_id = var.vpc_id
  route {
    cidr_block = var.out_cidr_block
    gateway_id = var.gateway_id
  }

  tags = {
    "Name" = "hassan_public_rt"
}
// create private route table
}
resource "aws_route_table" "hassan_route_table_private" {
  count = !var.is_public ? 1 : 0
  vpc_id = var.vpc_id

  tags = {
    "Name" = "hassan_private_rt"
}
}

// Associate public route table to subnet
resource "aws_route_table_association" "rt_subnet_association_public" {
  count = var.is_public ? 1 : 0
  route_table_id = aws_route_table.hassan_route_table_public[count.index].id
  subnet_id      = aws_subnet.hassan_subnet_public[count.index].id
}


// Associate private route table to subnet
resource "aws_route_table_association" "rt_subnet_association_private" {
  count = !var.is_public ? 1 : 0
  route_table_id = aws_route_table.hassan_route_table_private[count.index].id
  subnet_id      = aws_subnet.hassan_subnet_private[count.index].id
}

// security group public
resource "aws_security_group" "hassan_sg_public" {
  count = var.is_public ? 1 : 0
  vpc_id = var.vpc_id
//////////////
// delete this later 
/*     ingress {
      description = "SSH Access from everywhere"
      cidr_blocks = [ var.out_cidr_block ]
      from_port = 22
      protocol = "tcp"
      to_port = 22
    } */
////////////////  
    ingress {
      cidr_blocks = [ var.vpc_cidr_block ]
      from_port = 22
      protocol = "tcp"
      to_port = 22
    }

    ingress  {
      cidr_blocks = [ var.vpc_cidr_block ]
      from_port = 80
      protocol = "tcp"
      to_port = 80
    }

 
    ingress {
      cidr_blocks = [ var.vpc_cidr_block ]
      from_port = 443
      protocol = "tcp"
      to_port = 443
    }

 
    ingress {
      cidr_blocks = [ var.vpc_cidr_block ]
      from_port = 8081
      protocol = "tcp"
      to_port = 8081
    }
 
    ingress {
      description = "Ping"
      cidr_blocks = [ var.out_cidr_block ]
      from_port = -1
      protocol = "icmp"
      to_port = -1
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [var.out_cidr_block]
        
    }
    tags = {
        "Name" = "hassan_sg_public"
    }
}

// security group private
resource "aws_security_group" "hassan_sg_private" {
  count = !var.is_public ? 1 : 0
    vpc_id = var.vpc_id

/*     ingress {
      cidr_blocks = [ var.ip_public ]
      from_port = 22
      protocol = "tcp"
      to_port = 22
    } */

  // ingress for RDS DB
  ingress {
      cidr_blocks =  [var.pri_subnet_cidr_block]
      from_port = 3306
      protocol = "tcp"
      to_port = 3306
    }

  egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [var.out_cidr_block]       
    }
    tags = {
        "Name" = "hassan_sg_private"
    }
}

