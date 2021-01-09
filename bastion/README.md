# devkit-bastion
### Purpose
This role automates provisioning and configuration of a bastion node to 
speed up the deployment/artifact gathering process. Ansible will generate 
the terraform `variables.tf` and `bastion.tf` files  based on variables defined
in `<ROLE_PATH>/vars/main.yml`.

### Motiviation
In the spirit of simpl'r and faster, developed this to reduce even further the
compexities of getting started in a succinct readable (hopefully) way to get 
you started. 

### Requirements / Pre-Requisites (for best results)
1. Terraform > 0.12 
2. Ansible 2.9.10
3. AWS Credentials
4. boto3/botocore - `pip3 install awscli --user`

### Role Workflow
1. git clone repo && cd bastionbuilder
2. edit `vars/main.yml` with appropriate values (see table below for required input)
3. run site.yml playbook
4. profit

### What's Happening?
Once the variables have been updated, the role will do a lookup using your pre-defined
credentials in `~/.aws/credentials` to gather:
- vpc_id
- vpc_name
- subnet_name
- subnet_id 
- RHEL8 AMI ID 

Then based off the variable inputs, ansible will generate the variables.tf file which is used
directly by the bastion.tf file for provisioning the ec2 resource and its associated security group.
Terraform then uses cloud-init via user_data template to update and install podman, vim and git. 

Finally, ansible is parsing the state from terraform to generate a local file with the public ip 
address to simplify the accessibility of the ec2 instance.

## Variables

### Required Variables
Variable Name | Example Setting | Description
------------- | --------------- | ----------- 
cloud         | `c1d`           | Cloud Environment: Azure/Gov AWS/Gov, c1d
bastion_public_ssh_key_name | `jimbob-aws-pubkey` | Name of public key in AWS 
ssh_private_key_path | `~/.ssh/id_rsa.pem` | Path to the private key (used for remote-exec in terraform)
terraform_dir | /tmp/terraform | Some path that's writeable where you want terraform executed.

#### Lookup variables - Looked up via Ansible
Variable Name | Example Setting | Description
------------- | ------------- | ---------------
vpc_id     | `vpc-1234abcde` | Ansible lookup on VPC ID
vpc_name   | `vpc01`         | Ansible lookup on VPC Name
subnet_id  | `subnet-1234567890abcdefg` | The subnet to provision bastion to
bastion_ami_id | `ami-d281d2b3` | Ansible lookup based on RHEL 8.1 (latest in AWS)

#### Default Variables - Optional Override
Variable Name | Example Setting | Description
------------- | --------------- | -----------
cloud | `c1d` | Include tasks specific to lookups in c1d
aws_region   | `us-gov-west-1`  | Override this variable if you are NOT in us-gov-west-1 region
bastion_name | {{ vpc_name }}-bastion | instance name
bastion_security_group_name | {{ vpc_name }}-bastion-sg| meaningful name for easy id
bastion_instance_type | `t2.xlarge` | [Size requirement from codeSparta](https://codectl.io/docs/user-guide#user-provided-low-side-unrestricted-prep-node)
ssh_user | `ec2-user` | Username to ssh into instance with
volume_size | `120` | Size of the root disk of bastion node. (Best results have been with > 100Gb disk)

### Want to tear down the bastion you made?
*Execute these steps from the machine that created the resource*
1. Change to your defined `terraform_dir`
2. `terraform destroy` or if you like livin' on the edge: `terraform destroy -auto-approve`
3. Remove the directory and/or provisioned contents.

### Want more information about codeSparta? See: https://codectl.io

