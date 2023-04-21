#---------------------------------------------------------------
# EKS Cluster
#---------------------------------------------------------------

module "eks_blueprints" {
  source = "github.com/aws-ia/terraform-aws-eks-blueprints?ref=main"

  cluster_name    = var.cluster_name
  cluster_version = "1.25"

  vpc_id             = var.vpc_id
  private_subnet_ids = var.private_subnet_ids

  managed_node_groups = {
    main = {
      node_group_name = "large-ondemand"
      subnet_ids      = var.private_subnet_ids

      instance_types = ["r5.large"]
      disk_size      = 50

      ami_type      = "AL2_x86_64" # BOTTLEROCKET_x86_64
      capacity_type = "ON_DEMAND"

      min_size     = 1
      max_size     = 4
      desired_size = 2
    }

    # gpu = {
    #   node_group_name = "gpu-ondemand"
    #   subnet_ids      = var.private_subnet_ids

    #   instance_types = ["p2.xlarge"]
    #   disk_size      = 100

    #   ami_type      = "AL2_x86_64_GPU"
    #   capacity_type = "ON_DEMAND"

    #   min_size     = 0
    #   max_size     = 2
    #   desired_size = 0
    # }
  }

  tags = var.tags
}

#---------------------------------------------------------------
# EKS Addons
#--------------------------------------------------------------

module "eks_blueprints_kubernetes_addons" {
  source = "github.com/aws-ia/terraform-aws-eks-blueprints//modules/kubernetes-addons?ref=main"

  eks_cluster_id = module.eks_blueprints.eks_cluster_id

  # EKS Addons
  enable_amazon_eks_vpc_cni = true
  amazon_eks_vpc_cni_config = {
    addon_version     = "v1.12.6-eksbuild.1"
    resolve_conflicts = "OVERWRITE"
  }

  enable_amazon_eks_coredns = true
  amazon_eks_coredns_config = {
    addon_version     = "v1.9.3-eksbuild.2"
    resolve_conflicts = "OVERWRITE"
  }

  enable_amazon_eks_kube_proxy = true
  amazon_eks_kube_proxy_config = {
    addon_version     = "v1.24.10-eksbuild.2"
    resolve_conflicts = "OVERWRITE"
  }

  enable_amazon_eks_aws_ebs_csi_driver = true
  enable_aws_efs_csi_driver            = true

  enable_aws_load_balancer_controller = true
  aws_load_balancer_controller_helm_config = {
    version = "1.4.8"
  }

  # K8s Add-ons
  enable_argocd = true
  argocd_helm_config = {
    version = "5.29.1"
  }

  enable_cluster_autoscaler = true

  enable_kube_prometheus_stack = true
  kube_prometheus_stack_helm_config = {
    namespace = "monitoring"
  }
  enable_external_secrets     = true
  enable_cert_manager         = true
  enable_nvidia_device_plugin = true
}
