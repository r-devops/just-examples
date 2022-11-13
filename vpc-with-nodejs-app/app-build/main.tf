resource "null_resource" "build" {
  triggers = {
    always = timestamp()
  }
  depends_on = [aws_ecr_repository.demo-app]
  provisioner "local-exec" {
    command = <<EOF
cd ${path.root}/app-source-code
aws ecr get-login-password | docker login --username AWS --password-stdin ${data.aws_caller_identity.current.account_id}.dkr.ecr.us-east-1.amazonaws.com
docker build -t ${aws_ecr_repository.demo-app.repository_url} .
docker push ${aws_ecr_repository.demo-app.repository_url}
EOF
  }
}