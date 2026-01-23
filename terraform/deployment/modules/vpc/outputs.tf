# Output variables to be used in other modules

output "subnet-pub1" {
  description = "Public Subnet 1 ID"
  value       = aws_subnet.public_1.id
}

output "subnet-pub2" {
  description = "Public Subnet 2 ID"
  value       = aws_subnet.public_2.id
}

output "subnet-pub3" {
  description = "Public Subnet 3 ID"
  value       = aws_subnet.public_3.id
}

output "subnet-pri1" {
  description = "Private Subnet 1 ID"
  value       = aws_subnet.private_1.id
}

output "subnet-pri2" {
  description = "Private Subnet 2 ID"
  value       = aws_subnet.private_2.id
}

output "subnet-pri3" {
  description = "Private Subnet 3 ID"
  value       = aws_subnet.private_3.id
}

