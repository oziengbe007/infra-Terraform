To deploy the infrastructure, 
run the az login to authenticate to the azure CLI api
run terraform validate to validate the code
run terraform init to download the terraform modules
set the secretes In the keyvault

admin_password
tenant_id

Once that is done, run the terraform plan to view the planned resources to be deployed.

run terraform apply to deploy resources.

The following resources will be deployed:

NIC(3) - network interface cards.

Web Vm - Virtual machines(2)

database vm - virtual machine(1)

Web subnet - subnet for the web vms

db subnet - subnet for the db vms

Vm backup  - backup for the VMs

VM backup policies

Vnet- Virtual network

Availability set - This deployment uses basic sku load balancer, so we are going to be needing an availability set.

Load balancer - this contains health probe to check the status of the VMs in the backend pool

Azure key vault - This is for storing secrets.

key vault Secret - the deployment will create a secret used for configuring the VMs profiles

Mssql - An Mssql server and a mssql database will be deployed



