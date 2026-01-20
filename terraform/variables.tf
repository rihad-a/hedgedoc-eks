# General

# VPC

variable "vpc-cidr" {
  type        = string
  description = "The CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "subnet-cidrblock-pub1" {
  type        = string
  description = "The CIDR block for public subnet 1"
  default     = "10.0.101.0/24"
}

variable "subnet-cidrblock-pub2" {
  type        = string
  description = "The CIDR block for public subnet 2"
  default     = "10.0.102.0/24"
}

variable "subnet-cidrblock-pub3" {
  type        = string
  description = "The CIDR block for public subnet 3"
  default     = "10.0.103.0/24"
}

variable "subnet-cidrblock-pri1" {
  type        = string
  description = "The CIDR block for private subnet 1"
  default     = "10.0.1.0/24"
}

variable "subnet-cidrblock-pri2" {
  type        = string
  description = "The CIDR block for private subnet 2"
  default     = "10.0.2.0/24"
}

variable "subnet-cidrblock-pri3" {
  type        = string
  description = "The CIDR block for private subnet 3"
  default     = "10.0.3.0/24"
}

variable "subnet-az-2a" {
  type        = string
  description = "Availability zone for the 'a' subnets"
  default     = "eu-west-2a"
}

variable "subnet-az-2b" {
  type        = string
  description = "Availability zone for the 'b' subnets"
  default     = "eu-west-2b"
}

variable "subnet-az-2c" {
  type        = string
  description = "Availability zone for the 'c' subnets"
  default     = "eu-west-2c"
}

variable "routetable-cidr" {
  type        = string
  description = "Destination CIDR for the route table"
  default     = "0.0.0.0/0"
}

variable "subnet-map_public_ip_on_launch_public" {
  type        = bool
  description = "Boolean to map public IP on launch for public subnets"
  default     = true
}

variable "subnet-map_public_ip_on_launch_private" {
  type        = bool
  description = "Boolean to map public IP on launch for private subnets"
  default     = false
}

# EKS Cluster

variable "ekscluster-name" {
  type        = string
  description = "The name of the EKS cluster"
  default     = "eks_labs"
}

variable "eks-version" {
  type        = number
  description = "The version of the EKS cluster"
  default     = 1.33
}

variable "iamrole-name" {
  type        = string
  description = "The name of the IAM role for the EKS cluster"
  default     = "eks-cluster"
}
