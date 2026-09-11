# Automate Nexus Deployment

## Overview
This lab demonstrates how to use **Ansible** to automate the installation, configuration, and deployment of **Sonatype Nexus Repository Manager** on a Linux server hosted on **DigitalOcean**. Rather than manually performing server setup tasks, the entire deployment process is defined in Ansible playbooks, enabling a repeatable and consistent approach to infrastructure and application management.

The objective of this project is to gain hands-on experience with Infrastructure as Code (IaC) and configuration management by automating the deployment of a production-style Nexus environment. The playbook provisions the target server, creates a dedicated Linux user for Nexus, installs the required Java runtime, configures the operating system, deploys Nexus Repository Manager, and verifies that the service is running successfully.

## Technologies used
* Ansible
* Nexus
* Digital Ocean (Droplet)
* Java
* Linux

## Project Description
* Create Server on Digital Ocean
* Write Ansible Playbook that creates Linux user for Nexus, configure server, installs and deploys Nexus and verifies that it is running successfully

## Steps

### 1. Provision a DigitalOcean Droplet 
Create a new Droplet with the following configuration: 
- **Datacenter**: Choose the closest datacenter to your location.
- **OS**: Ubuntu (latest available version).
- **Droplet Type**: Shared CPU - Basic.
- **CPU Option**: Regular SSD.
- **Plan**: Select a budget-friendly option such as:
   - **1 vCPU**
   - **1 GB RAM**
   - **25 GB SSD**
   - **1000 GB Transfer** 

### 2. Configure SSH Access 
- Generate an SSH key pair using DigitalOcean's documentation or your preferred method.
- Save the private key on your Ansible control node under: 
```
~/.ssh/
```

### 3. Record the Public IP Address
After the droplet is created, note its public IPv4 address

### 4. Configure the Ansible Inventory
Update your inventory (hosts) file with the Droplet information.
```
     [nodejs_server]
     YOUR_SERVER_IP ansible_user=<remote_user> ansible_ssh_private_key_file=~/.ssh/<private_key>
```
**Note**: Do not commit actual server IP addresses, private keys or other sensitive information to GitHub.

### 5. Run the playbook
```
  ansible-playbook -i hosts deploy-nexus.yaml
```

