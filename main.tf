provider "aws" {
  region = "us-west-2"
}

data "aws_subnet" "default" {
  id = "subnet-0faa99d5c6c643f68"

}
data "aws_eks_cluster" "eks" {
  name = "test-eks"
}
resource "aws_eks_node_group" "eks-node" {
  cluster_name    = data.aws_eks_cluster.eks.name
  node_group_name = "eks-node-group"
  node_role_arn   = "arn:aws:iam::382132680530:role/eks-node-group-role"
  subnet_ids      = data.aws_subnet.default[*].id
  scaling_config {
    desired_size = 3
    min_size     = 1
    max_size     = 3
  }
}