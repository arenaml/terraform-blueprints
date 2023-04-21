provider "aws" {
  region  = var.region
  profile = var.profile
}

provider "kubernetes" {
  host                   = module.eks.eks_cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.eks_cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.this.token
}

provider "helm" {
  kubernetes {
    host                   = module.eks.eks_cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.eks_cluster_certificate_authority_data)
    token                  = data.aws_eks_cluster_auth.this.token
  }
}

module "vpc" {
  source       = "./modules/vpc"
  cluster_name = local.cluster_name
  vpc_name     = local.vpc_name
  vpc_cidr     = local.vpc_cidr
  azs          = local.azs
  tags         = local.tags
}

module "eks" {
  source             = "./modules/eks"
  cluster_name       = local.cluster_name
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnets
  tags               = local.tags
}

module "s3-mlflow" {
  source     = "./modules/s3"
  name       = "arena-mlflow-artifacts"
  versioning = true
}

module "iam-s3-access" {
  source         = "./modules/iam-s3-access"
  cluster_name   = local.cluster_name
  iam_role_names = module.eks.managed_node_group_iam_role_names
  s3_bucket_arns = [module.s3-mlflow.arn]
}

module "secrets-manager-rds-mlflow" {
  source  = "./modules/secrets-manager"
  name    = "arena-rds-mlflow-secrets-${random_id.this.hex}"
  secrets = local.rds_mlflow_secrets
}

module "rds-mlflow" {
  source     = "./modules/rds"
  name       = "arena-rds"
  username   = local.rds_mlflow_secrets.username
  password   = local.rds_mlflow_secrets.password
  db_name    = local.rds_mlflow_secrets.db_name
  port       = local.rds_mlflow_secrets.port
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.public_subnets
  tags       = local.tags
}

# module "argo" {
#   source         = "./modules/argo"
#   s3_bucket_name = module.s3.id
# }

module "ecr-landing-page" {
  source = "./modules/ecr"
  name   = "arena/landing-page"
}
