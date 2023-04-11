// create RDS instance
resource "aws_db_instance" "hassan_rds" {
  count = !var.is_public ? 1 : 0
  allocated_storage    = 10
  db_name              = "hassan_db"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  username             = "hassan"
  password             = "hassan"
  parameter_group_name = "hassan.mysql5.7"
  skip_final_snapshot  = true
//  subnet_id            = private.pri_subnet_cidr_block.id
  vpc_security_group_ids = [aws_security_group.hassan_sg_private[count.index].id]
}

// subnet for db
resource "aws_db_subnet_group" "db_subnet" {
  count = !var.is_public ? 1 : 0
  name       = "hassan_db_subnet"
  subnet_ids = aws_subnet.hassan_subnet_private[count.index].id

  tags = {
    Name = "hassan DB subnet"
  }
}