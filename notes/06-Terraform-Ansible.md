# Ansible and Terraform

## Introduction
Terraform and Ansible are often used together to automate the complete infrastructure lifecycle.

### Terraform
Terraform is primarily used for:
- Infrastructure provisioning
- Creating cloud resources
- Managing infrastructure as code

Examples:
- EC2 instances
- VPCs
- Subnets
- Security groups
- Load balancers

### Ansible
Ansible is primarily used for:
- Configuration management
- Application deployment
- Server administration
- Software installation

Examples:
- Installing Docker
- Deploying applications
- Configuring users
- Managing services
---

## Terraform + Ansible Workflow
A common workflow is:
1. Terraform provisions infrastructure.
2. Terraform retrieves the public IP addresses of newly created servers.
3. Ansible connects to the servers.
4. Ansible configures the operating system and applications.

Traditional process:
```text
Terraform creates EC2 instances
↓
Copy public IP addresses manually
↓
Update Ansible inventory file
↓
Run Ansible playbook
```
This approach works but introduces manual effort.

## Fully Automating Ansible Execution

Instead of manually updating inventory files, Terraform can automatically invoke Ansible after infrastructure provisioning.

### Example using local-exec
```
resource "aws_instance" "myapp_server_one" {
  ami = data.aws_ami.amazon_linux_image.id
  instance_type = var.instance_type
  subnet_id = aws_subnet.myapp-subnet.id
  vpc_security_group_ids = [aws_security_group.myapp-sg.id]  
  availability_zone = var.avail_zone
  associate_public_ip_address = true
  key_name = aws_key_pair.myapp-keypair.key_name
  tags = {
    Name = "${var.env_prefix}-server-1"
  }
  provisioner "local-exec" {
    command = "ansible-playbook -i ${self.public_ip}, --private-key ${var.ssh_private_key_location} --user ec2-user deploy_docker_tf_hosts.yaml"
  }
}
```
### What Happens?
When Terraform creates the EC2 instance:
1. The EC2 instance receives a public IP.
2. Terraform executes the local-exec provisioner.
3. Ansible runs immediately.
4. The public IP becomes a temporary inventory source.
---

## Using Dynamic Inventory

Notice the inventory parameter:
```
-i ${self.public_ip},
```

The trailing comma tells Ansible:
* Treat this value as a host inventory instead of an inventory file.

Example:
```
ansible-playbook -i 54.123.45.67, playbook.yml
```
This allows Ansible to target newly created infrastructure without maintaining a hosts file.

---
## Waiting for EC2 Provisioning

A common issue occurs when:

* Terraform finishes resource creation
* Ansible starts immediately
* SSH is not yet available

To avoid connection failures, add a waiting play.

Example:
```
---
- name: Wait for SSH Connection
  hosts: all
  gather_facts: false

  tasks:
    - name: Ensure SSH port is available
      wait_for:
        port: 22
        delay: 15
        timeout: 300
        search_regex: OpenSSH
        host: "{{ (ansible_ssh_host | default(ansible_host)) | default(inventory_hostname) }}"
      delegate_to: localhost

      vars:
        ansible_python_interpreter: /usr/bin/python3
```
### How the Wait Play Works

The wait_for module:
* Checks whether SSH is available
* Waits for EC2 boot completion
* Prevents connection errors
* Ensures remaining plays execute successfully

#### Parameters
**port**
```
port: 22
```
SSH port.

**delay**
```
delay: 15
```
Wait 15 seconds before starting checks.

**timeout**
```
timeout: 300
```
Stop checking after 5 minutes.

**delegate_to**
```
delegate_to: localhost
```
Run the check from the Ansible control node rather than the target host.

---

## Updating Existing Playbooks

When using Terraform-generated inventory, update playbooks so they target all hosts.

Instead of:
```
  hosts: webservers
```
Use:
```
  hosts:all
```
Benefits:
* Works with Terraform-generated hosts
* Supports dynamic provisioning
* No inventory maintenance required

