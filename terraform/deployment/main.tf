# VPC Module

module "aws_vpc" {
  source = "./modules/vpc"

  vpc-cidr                               = var.vpc-cidr
  subnet-cidrblock-pub1                  = var.subnet-cidrblock-pub1
  subnet-cidrblock-pub2                  = var.subnet-cidrblock-pub2
  subnet-cidrblock-pub3                  = var.subnet-cidrblock-pub3
  subnet-cidrblock-pri1                  = var.subnet-cidrblock-pri1
  subnet-cidrblock-pri2                  = var.subnet-cidrblock-pri2
  subnet-cidrblock-pri3                  = var.subnet-cidrblock-pri3
  subnet-az-2a                           = var.subnet-az-2a
  subnet-az-2b                           = var.subnet-az-2b
  subnet-az-2c                           = var.subnet-az-2c
  routetable-cidr                        = var.routetable-cidr
  subnet-map_public_ip_on_launch_public  = var.subnet-map_public_ip_on_launch_public
  subnet-map_public_ip_on_launch_private = var.subnet-map_public_ip_on_launch_private

  # Use these outputs
}

# EKS Module

module "eks" {
  source = "./modules/eks"


  ekscluster-name = var.ekscluster-name
  eks-version     = var.eks-version
  iamrole-name    = var.iamrole-name
  ng-name         = var.ng-name
  ng-instancetype = var.ng-instancetype
  ng-capacitytype = var.ng-capacitytype
  ng-desiredsize  = var.ng-desiredsize
  ng-maxsize      = var.ng-maxsize
  ng-minsize      = var.ng-minsize
  ng-rolename     = var.ng-rolename

  # Use these outputs
  subnet-pub1 = module.aws_vpc.subnet-pub1
  subnet-pub2 = module.aws_vpc.subnet-pub2
  subnet-pub3 = module.aws_vpc.subnet-pub3
  subnet-pri1 = module.aws_vpc.subnet-pri1
  subnet-pri2 = module.aws_vpc.subnet-pri2
  subnet-pri3 = module.aws_vpc.subnet-pri3
}


# Pod Identity Association Module

module "pod-identity-association" {
  source = "./modules/pod-identity-association"

  podidentity-rolename           = var.podidentity-rolename
  podidentity-namespace          = var.podidentity-namespace
  podidentity-sa                 = var.podidentity-sa
  certmanager-rolename           = var.certmanager-rolename
  certmanager-policyname         = var.certmanager-policyname
  certmanager-namespace          = var.certmanager-namespace
  certmanager-sa                 = var.certmanager-sa
  extdns-rolename                = var.extdns-rolename
  extdns-policyname              = var.extdns-policyname
  extdns-namespace               = var.extdns-namespace
  extdns-sa                      = var.extdns-sa
  s3-rolename                    = var.s3-rolename
  s3-policyname                  = var.s3-policyname
  eso-rolename                   = var.eso-rolename
  eso-policyname                 = var.eso-policyname
  eso-namespace                  = var.eso-namespace
  eso-sa                         = var.eso-sa

  # Use these outputs
  ekscluster-name = module.eks.ekscluster-name

}

# S3 module

module "s3" {
  source = "./modules/s3"

  s3-name                 = var.s3-name

  # Use these outputs

}

# RDS module

module "rds" {
  source = "./modules/rds"

  allocated-storage                = var.allocated-storage
  engine                           = var.engine
  engine-version                   = var.engine-version
  instance-class                   = var.instance-class
  password-length                  = var.password-length
  secretsmanager-name              = var.secretsmanager-name
  kmskey-deletionwindow            = var.kmskey-deletionwindow
  secretsmanager-recoverywindow    = var.secretsmanager-recoverywindow
  db-identifier                    = var.db-identifier
  db-storagetype                   = var.db-storagetype
  db-username                      = var.db-username
  db-parameter-group-name          = var.db-parameter-group-name
  db-skipfinalsnapshot             = var.db-skipfinalsnapshot
  db-publicaccess                  = var.db-publicaccess
  db-multiaz                       = var.db-multiaz
  db-backupretention               = var.db-backupretention

  # Use these outputs
  subnet-pri1    = module.aws_vpc.subnet-pri1
  subnet-pri2    = module.aws_vpc.subnet-pri2
  subnet-pri3    = module.aws_vpc.subnet-pri3
  vpc-id         = module.aws_vpc.vpc-id
  ekscluster-name = module.eks.ekscluster-name
  
  depends_on = [module.eks, module.aws_vpc]
}