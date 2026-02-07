# Output variables to be used in other modules

output "s3-role-arn" {
  description = "The S3 role ARN"
  value       = aws_iam_role.s3-role.arn
}