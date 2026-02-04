# Setting up KMS key 
resource "aws_kms_key" "rds" {
  description             = "KMS key for RDS"
  deletion_window_in_days = var.kmskey-deletionwindow
  is_enabled              = true
  enable_key_rotation     = true

}

# Setting up secrets manager

resource "random_password" "password" {
  length           = var.password-length
  special          = false
}

data "aws_secretsmanager_secret" "rds" {
  arn = "arn:aws:secretsmanager:eu-west-2:291759414346:secret:RDS-bvjyZM"
}

resource "aws_secretsmanager_secret_version" "secret" {
  secret_id     = data.aws_secretsmanager_secret.rds.id
  secret_string = random_password.password.result
}

# Setting up RDS


resource "aws_db_instance" "appdb" {
  identifier              = var.db-identifier
  allocated_storage       = var.allocated-storage
  storage_type            = var.db-storagetype
  engine                  = var.engine
  engine_version          = var.engine-version
  instance_class          = var.instance-class
  username                = var.db-username
  password                = aws_secretsmanager_secret_version.secret.secret_string
  parameter_group_name    = var.db-parameter-group-name
  skip_final_snapshot     = var.db-skipfinalsnapshot
  publicly_accessible     = var.db-publicaccess
  multi_az                = var.db-multiaz
  storage_encrypted       = true
  backup_retention_period = var.db-backupretention
  vpc_security_group_ids = [aws_security_group.rds-sg.id]
  db_subnet_group_name = aws_db_subnet_group.db-subnet-group.name

}

# create security group for the database

data "aws_eks_cluster" "eks" {
  name = var.ekscluster-name
}

resource "aws_security_group" "rds-sg" {
  name        = "rds security group"
  description = "enabling inbound traffic from the eks node groups"
  vpc_id      = var.vpc-id

  ingress {
    from_port        = 5432
    to_port          = 5432
    protocol         = "tcp"
    security_groups  = [data.aws_eks_cluster.eks.vpc_config[0].cluster_security_group_id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = -1
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

# Creating the subnet group for RDS
resource "aws_db_subnet_group" "db-subnet-group" {
  name         = "db subnet group"
  subnet_ids   = [var.subnet-pri1, var.subnet-pri2, var.subnet-pri3]
  description  = "The private subnet groups of the vpc"

}