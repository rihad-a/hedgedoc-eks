# VPC Variables

variable "vpc-cidr" {
  type        = string
  description = "The CIDR block for the VPC"
}

variable "subnet-cidrblock-pub1" {
  type        = string
  description = "The CIDR block for public subnet 1"
}

variable "subnet-cidrblock-pub2" {
  type        = string
  description = "The CIDR block for public subnet 2"
}

variable "subnet-cidrblock-pub3" {
  type        = string
  description = "The CIDR block for public subnet 3"
}

variable "subnet-cidrblock-pri1" {
  type        = string
  description = "The CIDR block for private subnet 1"
}

variable "subnet-cidrblock-pri2" {
  type        = string
  description = "The CIDR block for private subnet 2"
}

variable "subnet-cidrblock-pri3" {
  type        = string
  description = "The CIDR block for private subnet 3"
}

variable "subnet-az-2a" {
  type        = string
  description = "Availability zone for the 'a' subnets"
}

variable "subnet-az-2b" {
  type        = string
  description = "Availability zone for the 'b' subnets"
}

variable "subnet-az-2c" {
  type        = string
  description = "Availability zone for the 'c' subnets"
}

variable "routetable-cidr" {
  type        = string
  description = "Destination CIDR for the route table"
}

variable "subnet-map_public_ip_on_launch_public" {
  type        = bool
  description = "Boolean to map public IP on launch for public subnets"
}

variable "subnet-map_public_ip_on_launch_private" {
  type        = bool
  description = "Boolean to map public IP on launch for private subnets"
}

# EKS Cluster Variables

variable "ekscluster-name" {
  type        = string
  description = "The name of the EKS cluster"
}

variable "eks-version" {
  type        = number
  description = "The version of the EKS cluster"
}

variable "iamrole-name" {
  type        = string
  description = "The name of the IAM role for the EKS cluster"
}

variable "ng-name" {
  type        = string
  description = "The name for the Node Group"
}

variable "ng-instancetype" {
  type        = string
  description = "The instance type for the Node Group"
}

variable "ng-capacitytype" {
  type        = string
  description = "The capacity type for the Node Group"
}

variable "ng-desiredsize" {
  type        = number
  description = "The desired size for the Node Group"
}

variable "ng-maxsize" {
  type        = number
  description = "The max size for the Node Group"
}

variable "ng-minsize" {
  type        = number
  description = "The min size for the Node Group"
}

variable "ng-rolename" {
  type        = string
  description = "The name for the Node Group role"
}

# Pod Identity Association Variables

variable "podidentity-rolename" {
  type        = string
  description = "The name of the pod identity role"
}

variable "podidentity-namespace" {
  type        = string
  description = "The namespace of the pod identity"
}

variable "podidentity-sa" {
  type        = string
  description = "The service account of the pod identity"
}

variable "certmanager-rolename" {
  type        = string
  description = "The name of the certificate manager role"
}

variable "certmanager-policyname" {
  type        = string
  description = "The name of the certificate manager policy"
}

variable "certmanager-namespace" {
  type        = string
  description = "The namespace of the certificate manager"
}

variable "certmanager-sa" {
  type        = string
  description = "The service account of the certificate manager"
}

variable "extdns-rolename" {
  type        = string
  description = "The name of the external dns role"
}

variable "extdns-policyname" {
  type        = string
  description = "The name of the external dns policy"
}

variable "extdns-namespace" {
  type        = string
  description = "The namespace of the external dns"

}

variable "extdns-sa" {
  type        = string
  description = "The service account of the certificate manager"

}

variable "efs-csi-driver-rolename" {
  type        = string
  description = "The name of the efs csi driver role"
}

variable "efs-csi-driver-policyname" {
  type        = string
  description = "The name of the efs csi driver policy"
}

variable "efs-csi-driver-namespace" {
  type        = string
  description = "The namespace of the efs csi driver"
}

variable "efs-csi-driver-sa" {
  type        = string
  description = "The service account of the efs csi driver"
}

variable "eso-rolename" {
  type        = string
  description = "The name of the efs csi driver role"
}

variable "eso-policyname" {
  type        = string
  description = "The name of the efs csi driver policy"
}

variable "eso-namespace" {
  type        = string
  description = "The namespace of the efs csi driver"
}

variable "eso-sa" {
  type        = string
  description = "The service account of the efs csi driver"
}

# EFS Variables

variable "efs-name" {
  type = string
  description = "The EFS name"
}

variable "efs-sgname" {
  type = string
  description = "The EFS sg name"
}

variable "posix_user_uid" {
  description = "POSIX user ID for EFS access point"
  type        = number
}

variable "posix_user_gid" {
  description = "POSIX group ID for EFS access point"
  type        = number
}

# RDS Variables

variable "allocated-storage" {
  description = "The amount of storage to allocate"
  type        = number
  sensitive   = true
}

variable "engine" {
  description = "The database engine to use"
  type        = string
}

variable "engine-version" {
  description = "The engine version to use"
  type        = string
}

variable "instance-class" {
  description = "The instance class to use"
  type        = string
}

variable "password-length" {
  description = "The length of the password"
  type        = number
}

variable "secretsmanager-name" {
  description = "The name of the secrets manager"
  type        = string
}

variable "kmskey-deletionwindow" {
  description = "The number of days for the deletion window of the kms key"
  type        = number
}

variable "secretsmanager-recoverywindow" {
  description = "The number of days for the recovery window of the secrets manager"
  type        = number
}

variable "db-identifier" {
  description = "The identifier of the database"
  type        = string
}

variable "db-storagetype" {
  description = "The storage type of the database"
  type        = string
}

variable "db-username" {
  description = "The username of the database"
  type        = string
}

variable "db-parameter-group-name" {
  description = "The parameter group name of the database"
  type        = string
}

variable "db-skipfinalsnapshot" {
  description = "The optioning for skipping the final snapshot of the database"
  type        = bool
}

variable "db-publicaccess" {
  description = "The optioning for public access of the database"
  type        = bool
}

variable "db-multiaz" {
  description = "The optioning for a multi-az database"
  type        = bool
}

variable "db-backupretention" {
  description = "The number of days for the backup retention period of the database"
  type        = number
}