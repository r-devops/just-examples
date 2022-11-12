resource "aws_eks_cluster" "eks" {
  name     = "${var.env}-eks-cluster"
  role_arn = aws_iam_role.eks-cluster-role.arn
  version  = "1.23"

  vpc_config {
    subnet_ids = var.PRIVATE_SUBNET_IDS
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.AmazonEKSVPCResourceController,
  ]
}
