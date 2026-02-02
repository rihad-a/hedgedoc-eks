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

# Module Variables 

variable "subnet-pri1" {
  type        = string
  description = "Private Subnet 1 ID"
}

variable "subnet-pri2" {
  type        = string
  description = "Private Subnet 2 ID"
}

variable "subnet-pri3" {
  type        = string
  description = "Private Subnet 3 ID"
}

variable "vpc-id" {
  type = string
  description = "The vpc id"
}

variable "ekscluster-id" {
  type = string
  description = "The id of the EKS cluster"
}
