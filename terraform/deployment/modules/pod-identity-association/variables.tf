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

# Module Variables 

variable "ekscluster-name" {
  type        = string
  description = "The EKS cluster name"

}
