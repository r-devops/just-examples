resource "null_resource" "get-kube-config" {
  provisioner "local-exec" {
    command = "aws eks update-kubeconfig  --name ${var.env}-eks-cluster"
  }
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = data.aws_eks_cluster.eks.arn
}

