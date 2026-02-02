# Output variables to be used in other modules

output "ekscluster" {
  description = "The EKS cluster"
  value       = aws_eks_cluster.eks
}

output "ekscluster-name" {
  description = "The name of the EKS cluster"
  value       = aws_eks_cluster.eks.name
}

output "ekscluster-id" {
  description = "The id of the EKS cluster"
  value       = aws_eks_cluster.eks.id
}
