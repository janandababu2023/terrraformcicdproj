provider "aws" {
  region = "ap-south-1"
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.eks.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.eks.token
}

data "aws_availability_zones" "available" {}

output "cluster_name" {
  value = module.eks.cluster_name
}
