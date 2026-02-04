# Setting up EFS

resource "aws_efs_file_system" "eks-efs" {
  creation_token = var.efs-name
  encrypted = "true"
}


# EFS Mount Targets (For each private subnet id)

resource "aws_efs_mount_target" "main" {
  count           = length(var.pri-subnet-ids)
  file_system_id  = aws_efs_file_system.eks-efs.id
  subnet_id       = var.pri-subnet-ids[count.index]
  security_groups = [aws_security_group.efs.id]
}

# EFS Security Group 

resource "aws_security_group" "efs" {
  name_prefix = var.efs-sgname
  vpc_id      = var.vpc-id

  ingress {
    description = "NFS from EKS nodes"
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = [var.vpc-cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EFS Access Point 

resource "aws_efs_access_point" "pod_access_point" {
  file_system_id = aws_efs_file_system.eks-efs.id

  posix_user {
    gid = var.posix_user_gid
    uid = var.posix_user_uid
  }

  root_directory {
    path = "./public/uploads"
    creation_info {
      owner_gid   = var.posix_user_gid
      owner_uid   = var.posix_user_uid
      permissions = "775"
    }
  }
}