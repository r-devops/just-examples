resource "null_resource" "get-kube-config" {
  provisioner "local-exec" {
    command = "aws eks update-kubeconfig  --name ${var.env}-eks-cluster"
  }
}


