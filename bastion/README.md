# devkit-bastion
### Purpose
This role automates provisioning and configuration of a bastion node to 
speed up the deployment/artifact gathering process. Ansible will generate 
the terraform `variables.tf` and `bastion.tf` files  based on variables defined
in `<ROLE_PATH>/vars/main.yml`.

### Motiviation
In the spirit of simpl'r and faster. Developed this to reduce even further the
compexities of getting started in a succinct readable (hopefully) way to get 
you started. 

### Requirements / Pre-Requisites (for best results)
1. Terraform > 0.12 
2. Ansible 2.9.10
3. AWS Credentials
4. boto3/botocore - `pip3 install // install awscli`

### Role Workflow
1. git clone repo && cd bastionbuilder
2. edit `vars/main.yml` with appropriate values (see table below for generic input)
3. run site.yml playbook
4. profit

### What's Happening?
Once the variables have been updated, the role will do a lookup using your pre-defined
credentials in `~/.aws/credentials` to gather the default vpc id and the RHEL8 AMI (which
is part of the pre-reqs list from Sparta).

Then based off the variable inputs, ansible will generate the variables.tf file which is used
directly by the bastion.tf file for provisioning the ec2 resource and its associated security group.
Terraform is using a remote-exec provisioner to install the prerequisite packages on the node, and 
then running a `dnf update -y` against that machine. 

Finally, ansible is parsing the state from terraform to generate a local file with the public ip 
address to simplify the accessibility of the ec2 instance.

### Variables

#### Default Variables 
*You should not modify these or YMMV*
Variable Name | Example Setting | Description
------------- | ------------- | ---------------
vpc_id     | `vpc-1234abcde` | Ansible lookup on 'DEFAULT' vpc
bastion_ami_id | `ami-d281d2b3` | Ansible lookup based on RHEL 8.1 (latest in AWS)
aws_region | `us-gov-west-1` | Override this variable if you are NOT in us-gov-west-1 region

#### Configurable Variables (with example settings)
Variable Name | Example Setting | Description
------------- | --------------- | -----------
bastion_name | jimbob-ocp4-bastion | meaningful name for easy id
bastion_security_group_name | jimbob-ocp4-bastion-sg | meaningful name for easy id
bastion_instance_type | `t2.xlarge` | [Size requirement from codeSparta](https://codectl.io/docs/user-guide#user-provided-low-side-unrestricted-prep-node)
bastion_public_ssh_key_name | `jimbob-aws-pubkey` | Name of public key in AWS 
ssh_private_key_path | `~/.ssh/jimbob-aws.pem` | Path to the private key (used for remote-exec in terraform)
ssh_user | `ec2-user` | Username to ssh into instance with
volume_size | `120` | Size of the root disk of bastion node. (Best results have been with > 100Gb disk)
terraform_dir | /data/terraform | Some path that's writeable where you want terraform executed.


### Want to tear down the bastion you made?
*Execute these steps from the machine that created the resource*
1. Change to your defined `terraform_dir`
2. `terraform destroy` or if you like livin' on the edge: `terraform destroy -auto-approve`
3. Remove the directory and/or provisioned contents.

### Want more information about codeSparta? See: https://codectl.io

