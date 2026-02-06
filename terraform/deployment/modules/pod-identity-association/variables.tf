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

variable "eso-rolename" {
  type        = string
  description = "The name of the eso role"
}

variable "eso-policyname" {
  type        = string
  description = "The name of the eso policy"
}

variable "eso-namespace" {
  type        = string
  description = "The namespace of the eso"
}

variable "eso-sa" {
  type        = string
  description = "The service account of the eso"
}

variable "s3-rolename" {
  type        = string
  description = "The name of the efs csi driver role"
}

variable "s3-policyname" {
  type        = string
  description = "The name of the efs csi driver policy"
}

# Module Variables 

variable "ekscluster-name" {
  type        = string
  description = "The EKS cluster name"

}
