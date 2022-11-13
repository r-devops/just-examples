data "aws_eks_cluster" "eks" {
  name = "${var.env}-eks-cluster"
}

