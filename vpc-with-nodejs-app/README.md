This is a monorepo that has all terraform modules, Application Repo, & Helm Chart to Deploy.

Following are the security considerations that was made while making this setup. 

Infra:
------

1. A Separate VPC. 
2. Public and Private Subnets with two AZ for HA. 
3. K8S Cluster running in Private Subnets. 
4. Application is exposed over ingress.
5. WAF Attached to Ingress to Protect Application.

Application:
-------

1. Create Docker Image with minimal Nodejs modules. 
2. Run the container as nonroot user. 


Steps to setup this:
-------

PRE-REQUISITES:
----

1. Makefile 
2. Terraform 
3. Docker 
4. Helm 

Setup steps:
----
1. Configure AWS Creds with `aws configure`
2. `make build` - Builds Container Image from Dockerfile.
3. `make terraform-apply` - Terraform Apply 
4. `make app-deploy` - Deploy Helm Chart 


Things can be improved.
----

1. Remote Terraform S3 statefile with DynamoDB locking 
2. 
