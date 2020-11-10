terraform init
terraform validate
terraform plan -out=tfplan -input=false
terraform apply "tfplan"