To deploy the infrastructure, 
run the az login to authenticate to the azure CLI api
run terraform validate to validate the code
run terraform init to download the terraform modules
set the secretes In the keyvault

admin_password
tenant_id

Once that is done, run the terraform plan to view the planned resources to be deployed.

run terraform apply to deploy resources.
