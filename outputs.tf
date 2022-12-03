#---------------------------------------------------------------
# VPC
#---------------------------------------------------------------

output "private_subnet_cidr" {
  description = "VPC private subnet CIDR"
  value       = module.vpc.private_subnets_cidr_blocks
}

output "public_subnets_cidr_blocks" {
  description = "VPC public subnet CIDR"
  value       = module.vpc.public_subnets_cidr_blocks
}

output "vpc_cidr_block" {
  description = "VPC CIDR"
  value       = module.vpc.vpc_cidr_block
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.vpc.private_subnets
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

#---------------------------------------------------------------
# EKS 
#---------------------------------------------------------------

output "eks_cluster_id" {
  description = "EKS cluster ID"
  value       = module.eks.eks_cluster_id
}

output "eks_cluster_endpoint" {
  description = "Endpoint for your Kubernetes API server"
  value       = module.eks.eks_cluster_endpoint
}

output "eks_cluster_certificate_authority_data" {
  description = "Base64 encoded certificate data required to communicate with the cluster"
  value       = module.eks.eks_cluster_certificate_authority_data
}

output "cluster_primary_security_group_id" {
  description = "Cluster security group that was created by Amazon EKS for the cluster. Managed node groups use this security group for control-plane-to-data-plane communication. Referred to as 'Cluster security group' in the EKS console"
  value       = module.eks.cluster_primary_security_group_id
}

output "managed_node_groups" {
  description = "EKS managed node groups"
  value       = module.eks.managed_node_groups
}

output "managed_node_groups_id" {
  description = "EKS managed node group ids"
  value       = module.eks.managed_node_groups_id
}

output "managed_node_group_arn" {
  description = "EKS managed node group arns"
  value       = module.eks.managed_node_group_arn
}

output "managed_node_group_iam_role_names" {
  description = "EKS managed node group role name"
  value       = module.eks.managed_node_group_iam_role_names
}

output "managed_node_groups_status" {
  description = "EKS managed node group status"
  value       = module.eks.managed_node_groups_status
}

output "configure_kubectl" {
  description = "Configure kubectl: make sure you're logged in with the correct AWS profile and run the following command to update your kubeconfig"
  value       = module.eks.configure_kubectl
}

#---------------------------------------------------------------
# S3
#---------------------------------------------------------------

output "s3_bucket_id" {
  value = module.s3.id
}

output "s3_bucket_arn" {
  value = module.s3.arn
}

#---------------------------------------------------------------
# IAM S3 Access
#---------------------------------------------------------------

output "aws_iam_policy_arn" {
  value = module.iam-s3-access.arn
}

output "aws_iam_policy_name" {
  value = module.iam-s3-access.name
}

#---------------------------------------------------------------
# ECR
#---------------------------------------------------------------

output "ecr_landing_page_repository_url" {
  value       = module.ecr-landing-page.repository_url
  description = "The URL of the landing page repository (in the form aws_account_id.dkr.ecr.region.amazonaws.com/repositoryName)"
}

output "ecr_landing_page_arn" {
  value       = module.ecr-landing-page.arn
  description = "Full ARN of the landing page repository"
}

output "ecr_landing_page_registry_id" {
  value       = module.ecr-landing-page.registry_id
  description = "The registry ID where the landing page repository was created"
}
