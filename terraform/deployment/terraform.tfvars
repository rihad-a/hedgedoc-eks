# VPC
vpc-cidr                               = "10.0.0.0/16"
subnet-cidrblock-pub1                  = "10.0.101.0/24"
subnet-cidrblock-pub2                  = "10.0.102.0/24"
subnet-cidrblock-pri1                  = "10.0.1.0/24"
subnet-cidrblock-pri2                  = "10.0.2.0/24"
subnet-az-2a                           = "eu-west-2a"
subnet-az-2b                           = "eu-west-2b"
routetable-cidr                        = "0.0.0.0/0"
subnet-map_public_ip_on_launch_public  = true
subnet-map_public_ip_on_launch_private = false

# EKS Cluster

ekscluster-name = "eks-cluster"
iamrole-name    = "eks-cluster-role"
eks-version     = 1.33
ng-name         = "eks-node-group"
ng-instancetype = "t3.large"
ng-capacitytype = "SPOT"
ng-desiredsize  = 2
ng-maxsize      = 4
ng-minsize      = 2
ng-rolename     = "eks-node-group-role"

# Pod Identity Association 

podidentity-rolename           = "eks-pod-identity-role"
podidentity-namespace          = "pod-identity"
podidentity-sa                 = "pod-identity"
certmanager-rolename           = "cert-manager-role"
certmanager-policyname         = "cert-manager-policy"
certmanager-namespace          = "cert-manager"
certmanager-sa                 = "cert-manager"
extdns-rolename                = "external-dns-role"
extdns-policyname              = "external-dns-policy"
extdns-namespace               = "external-dns"
extdns-sa                      = "external-dns"
s3-rolename                    = "s3-role"
s3-policyname                  = "s3-policy"
s3-namespace                   = "hedgedoc-app"
s3-sa                          = "hedgedoc"
eso-rolename                   = "eso-role"
eso-policyname                 = "eso-policy"
eso-namespace                  = "external-secrets"
eso-sa                         = "external-secrets"

# S3

s3-name                       = "s3-mediaupload"
block-public-acl              = true
block-public-policy           = false
ignore-public-acls            = true
restrict-public-buckets       = true


# RDS

allocated-storage             = 20
engine                        = "postgres"
engine-version                = "17.6"
instance-class                = "db.t3.micro"
password-length               = 10
secretsmanager-name           = "rds"
kmskey-deletionwindow         = 7
secretsmanager-recoverywindow = 14
db-identifier                 = "appdb"
db-storagetype                = "gp2"
db-username                   = "eksdb"
db-parameter-group-name       = "default.postgres17"
db-skipfinalsnapshot          = true
db-publicaccess               = false
db-multiaz                    = false
db-backupretention            = 7


