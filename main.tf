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

module "s3" {
  source = "./modules/s3"
  name   = "arena"
}

module "iam-s3-access" {
  source         = "./modules/iam-s3-access"
  cluster_name   = local.cluster_name
  iam_role_names = module.eks.managed_node_group_iam_role_names
  s3_bucket_arn  = module.s3.arn
}

module "secrets-manager" {
  source = "./modules/secrets-manager"
  name   = "arena"
}

module "rds" {
  source     = "./modules/rds"
  name       = "arena-rds"
  username   = module.secrets-manager.secret-rds-username
  password   = module.secrets-manager.secret-rds-password
  db_name    = module.secrets-manager.secret-rds-db-name
  port       = module.secrets-manager.secret-rds-port
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.public_subnets
  tags       = local.tags
}

module "argo" {
  source         = "./modules/argo"
  s3_bucket_name = module.s3.id
}

module "ecr-landing-page" {
  source = "./modules/ecr"
  name   = "arena/landing-page"
}
