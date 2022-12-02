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

## TODO
# module "iam" {
#   source         = "./../iam"
#   cluster_name   = var.cluster_name
#   iam_role_names = module.eks_blueprints.managed_node_group_iam_role_names
# }

# module "metaflow" {
#   source         = "./modules/metaflow"
#   vpc_id         = module.vpc.vpc_id
#   subnet1_id     = module.vpc.private_subnets[0]
#   subnet2_id     = module.vpc.private_subnets[1]
#   vpc_cidr_block = module.vpc.vpc_cidr_block
#   cluster_name   = local.cluster_name
#   tags           = local.tags
# }
