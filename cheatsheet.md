clear
cd ~/homelab/terraform/environments/production/us-west-2/application
terraform init -backend-config=../../../../terraform.tfbackend -reconfigure
terraform apply --auto-approve

clear
cd ~/homelab/terraform/environments/production/us-west-2/control
terraform init -backend-config=../../../../terraform.tfbackend -reconfigure
terraform apply --auto-approve

clear
cd ~/homelab/terraform/environments/production/us-west-2/database
terraform init -backend-config=../../../../terraform.tfbackend -reconfigure
terraform apply --auto-approve

clear
cd ~/homelab/terraform/environments/production/us-west-2/peering
terraform init -backend-config=../../../../terraform.tfbackend -reconfigure
terraform apply --auto-approve

----------------------------------------

clear
cd ~/homelab/terraform/environments/development/us-west-2/application
terraform init -backend-config=../../../../terraform.tfbackend -reconfigure
terraform apply --auto-approve

clear
cd ~/homelab/terraform/environments/development/us-west-2/database
terraform init -backend-config=../../../../terraform.tfbackend -reconfigure
terraform apply --auto-approve

clear
cd ~/homelab/terraform/environments/development/us-west-2/peering
terraform init -backend-config=../../../../terraform.tfbackend -reconfigure
terraform apply --auto-approve


----------------------------------------

clear
cd ~/homelab/terraform/environments/mirror/us-west-2/application
terraform init -backend-config=../../../../terraform.tfbackend -reconfigure
terraform apply --auto-approve

clear
cd ~/homelab/terraform/environments/mirror/us-west-2/database
terraform init -backend-config=../../../../terraform.tfbackend -reconfigure
terraform apply --auto-approve

clear
cd ~/homelab/terraform/environments/mirror/us-west-2/peering
terraform init -backend-config=../../../../terraform.tfbackend -reconfigure
terraform apply --auto-approve


----------------------------------------

clear
cd ~/homelab/terraform/environments/staging/us-west-2/application
terraform init -backend-config=../../../../terraform.tfbackend -reconfigure
terraform apply --auto-approve

clear
cd ~/homelab/terraform/environments/staging/us-west-2/database
terraform init -backend-config=../../../../terraform.tfbackend -reconfigure
terraform apply --auto-approve

clear
cd ~/homelab/terraform/environments/staging/us-west-2/peering
terraform init -backend-config=../../../../terraform.tfbackend -reconfigure
terraform apply --auto-approve

