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


