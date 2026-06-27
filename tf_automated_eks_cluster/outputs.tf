############################
# VPC OUTPUTS
############################

output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "private_subnets" {
  description = "Private Subnet IDs"
  value       = module.vpc.private_subnets
}

output "public_subnets" {
  description = "Public Subnet IDs"
  value       = module.vpc.public_subnets
}

output "intra_subnets" {
  description = "Intra Subnet IDs"
  value       = module.vpc.intra_subnets
}

output "nat_public_ips" {
  description = "NAT Gateway Public IPs"
  value       = module.vpc.nat_public_ips
}


############################
# EKS OUTPUTS
############################

output "oidc_provider_arn" {
  description = "EKS OIDC Connecter"
  value       = module.eks.oidc_provider_arn
}

output "cluster_name" {
  description = "EKS Cluster Name"
  value       = module.eks.cluster_name
}

output "cluster_arn" {
  description = "EKS Cluster ARN"
  value       = module.eks.cluster_arn
}

output "cluster_endpoint" {
  description = "EKS Cluster Endpoint"
  value       = module.eks.cluster_endpoint
}

output "cluster_version" {
  description = "Kubernetes Version"
  value       = module.eks.cluster_version
}

output "cluster_security_group_id" {
  description = "Cluster Security Group"
  value       = module.eks.cluster_security_group_id
}

output "node_security_group_id" {
  description = "Node Security Group"
  value       = module.eks.node_security_group_id
}

############################
# NODE GROUP OUTPUTS
############################

output "eks_managed_node_groups" {
  description = "Managed Node Groups"
  value       = module.eks.eks_managed_node_groups
}


############################
# ALB CONTROLLER OUTPUTS
############################

output "alb_controller_role_arn" {
  description = "ALB Controller IAM Role"
  value       = module.alb_irsa.iam_role_arn
}


############################
# KARPENTER OUTPUTS
############################

output "karpenter_role_arn" {
  description = "Karpenter IAM Role"
  value       = module.karpenter_irsa.iam_role_arn
}

output "karpenter_node_role_arn" {
  description = "Karpenter Node IAM Role"
  value       = aws_iam_role.karpenter_node.arn
}

############################
# KUBECTL COMMAND
############################

output "kubectl_configure" {
  description = "Command to configure kubectl"
  value       = "aws eks update-kubeconfig --region ${local.region} --name ${module.eks.cluster_name}"
}