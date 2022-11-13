resource "null_resource" "deploy-helm-chart" {
  triggers = {
    always = timestamp()
  }
  provisioner "local-exec" {
    command = <<EOF
helm upgrade -i demo-app ${path.module}/helm
EOF
  }
}
