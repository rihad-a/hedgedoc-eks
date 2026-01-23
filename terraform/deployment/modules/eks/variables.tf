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

# Module Variables 

variable "subnet-pub1" {
  type        = string
  description = "Public Subnet 1 ID"
}

variable "subnet-pub2" {
  type        = string
  description = "Public Subnet 2 ID"
}

variable "subnet-pub3" {
  type        = string
  description = "Public Subnet 3 ID"
}

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