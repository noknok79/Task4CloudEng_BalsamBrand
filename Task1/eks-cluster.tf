module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.13.1"

  cluster_name    = local.cluster_name
  cluster_version = "1.27"

  vpc_id                         = module.vpc.vpc_id
  subnet_ids                     = module.vpc.private_subnets
  cluster_endpoint_public_access = true

  eks_managed_node_group_defaults = {
    ami_type = "AL2_x86_64"
  }

  eks_managed_node_groups = {
    one = {
      name = "node-group-1"
      instance_types = ["t3.micro"]
      min_size     = 1
      max_size     = 2
      desired_size = 2
    }

    two = {
      name = "node-group-2"
      instance_types = ["t3.small"]
      min_size     = 1
      max_size     = 2
      desired_size = 2
    }
  }
}

resource "aws_eks_addon" "coredns" {
  #count = var.addon_create_coredns ? 1 : 0

  cluster_name                = module.eks.cluster_id
  addon_name                  = "coredns"
  resolve_conflicts_on_update = "OVERWRITE"
  addon_version               = "v1.10.1-eksbuild.1"

  #tags = local.tags
}


resource "aws_eks_addon" "kube_proxy" {
  #count = var.addon_create_kube_proxy ? 1 : 0

  cluster_name                = module.eks.cluster_id
  addon_name                  = "kube-proxy"
  resolve_conflicts_on_update = "OVERWRITE"
  addon_version               = "v1.10.1-eksbuild.1"

  #tags = local.tags
}


resource "aws_eks_addon" "vpc_cni" {
  #count = var.addon_create_vpc_cni ? 1 : 0

  cluster_name                = module.eks.cluster_id
  addon_name                  = "vpc-cni"
  resolve_conflicts_on_update = "OVERWRITE"
  addon_version               = "v1.10.1-eksbuild.1"

  #tags = local.tags
}
