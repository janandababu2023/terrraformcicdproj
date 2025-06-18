
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.8.4"

  cluster_name    = "eks-cluster"
  cluster_version = "1.29"

  cluster_endpoint_public_access = true

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.private_subnets

  eks_managed_node_groups = {
    ubuntu_nodes = {
      desired_size = 3
      min_size     = 3
      max_size     = 3

      instance_types = ["t3.medium"]
      ami_type       = "CUSTOM"

      ami_id = data.aws_ami.ubuntu.id

      labels = {
        role = "worker"
      }
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
