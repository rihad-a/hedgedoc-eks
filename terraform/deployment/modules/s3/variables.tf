# S3 Variables

variable "s3-name" {
  type = string
  description = "The S3 bucket name"
}

variable "block-public-acl" {
  type = bool
  description = "A setting to block public acls"
}

variable "block-public-policy" {
  type = bool
  description = "A setting to block public policy"
}

variable "ignore-public-acls" {
  type = bool
  description = "A setting to ignore public acls"
}

variable "restrict-public-buckets" {
  type = bool
  description = "A setting to restrict public buckets"
}

# Module Variables 

variable "s3-role-arn" {
  type       = string
  description = "The S3 role ARN"
}