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
