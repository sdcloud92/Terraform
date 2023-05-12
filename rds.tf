#create RDS MySQL Instance
resource "aws_db_instance" "Project-dbinstance" {
  allocated_storage = 20
  db_name           = "Project-dbinstance"
  engine            = "mysql"
  engine_version    = "5.7"
  instance_class    = "db.t2.micro"

  #credentials will be added as sensitive variables in Terraform Cloud
  username               = var.db_username
  password               = var.db_password
  vpc_security_group_ids = [aws_security_group.Project-mysql-sg.id]
  db_subnet_group_name   = "db-subnet-grp"
  skip_final_snapshot    = true
}

#subnet group for RDS instance
resource "aws_db_subnet_group" "Project-db-subnet-grp" {
  name       = "project-db-subnet-grp"
  subnet_ids = [aws_subnet.Project-privsub1.id, aws_subnet.Project-privsub2.id]

  tags = {
    Name = "Project DB private subnet group"
  }
}
