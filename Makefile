lint:
	echo "validating terraform"
	terraform fmt && terraform validate

.PHONY : install
install:
	echo "installing and planning"
	terraform init && terraform plan

.PHONY : install-approve
install-approve:
		echo "creating infrastructure"
		terraform apply -auto-approve

.PHONY : destroy
destroy:
	echo "destroying infrastructure"
	terraform destroy -auto-approve