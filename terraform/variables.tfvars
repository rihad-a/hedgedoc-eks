# General

# VPC
vpc-cidr                               = "10.0.0.0/16"
subnet-cidrblock-pub1                  = "10.0.101.0/24"
subnet-cidrblock-pub2                  = "10.0.102.0/24"
subnet-cidrblock-pub3                  = "10.0.103.0/24"
subnet-cidrblock-pri1                  = "10.0.1.0/24"
subnet-cidrblock-pri2                  = "10.0.2.0/24"
subnet-cidrblock-pri3                  = "10.0.3.0/24"
subnet-az-2a                           = "eu-west-2a"
subnet-az-2b                           = "eu-west-2b"
subnet-az-2c                           = "eu-west-2c"
routetable-cidr                        = "0.0.0.0/0"
subnet-map_public_ip_on_launch_public  = true
subnet-map_public_ip_on_launch_private = false

# EKS Cluster

ekscluster-name = "eks_labs"
iamrole-name    = "eks-cluster"
eks-version     = 1.33