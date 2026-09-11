# Automate Node.js Application Deployment
 
## Overview 
This lab demonstrates how to use **Ansible** to automate the provisioning and deployment of a **Node.js** application on a Linux server hosted on **DigitalOcean**. Instead of manually configuring the server, installing dependencies, creating users, and deploying application code, Ansible playbooks are used to define the entire process as code.
 
The objective is to gain hands-on experience with Infrastructure as Code (IaC) and configuration management by creating a repeatable deployment process. The playbooks automate server configuration, software installation, user creation, and application deployment, ensuring a consistent and reliable environment every time.
 
## Technologies Used 
- Ansible
- Node.js
- DigitalOcean (Droplet)
- Linux (Ubuntu)
- SSH
 
## Project Description 
- Create a Linux server on DigitalOcean (Droplet)
- Configure secure SSH access
- Write Ansible playbooks to:
- Install required software and dependencies
- Create a dedicated Linux user for the application
- Deploy a Node.js application package
- Start the application on the target server
- Demonstrate different methods of handling variables in Ansible:
- Hardcoded values
- Inline variables
- External variables file
 
## Prerequisites 
- Ansible installed on the control node
- DigitalOcean account
- SSH key pair
- Node.js application package (`nodejs-app-1.0.0.tgz`)
- Internet connectivity between the Ansible control node and the Droplet

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
 
```text
~/.ssh/


2. Note the Public IP address of the Droplet
3. In the Ansible control node, update the following entries in the hosts file with the Public IP address, private key file location in the Ansible control node and desired ansible user which will run on the remote Droplet
   ```
      YOUR_SERVER_IP ansible_user=<remote_user> ansible_ssh_private_key_file=~/.ssh/<private_key>
   ```
4. Save the **nodejs-app-1.0.0.tgz** package in a desired directory under the Ansible control node. I saved the package under **/home/my-ansible-project/nodejs** directory.
5. To run playbook with hardcoded values and does not use variables
   ```
      ansible-playbook -i hosts deploy-node-no-vars.yaml
   ```
6. To run a playbook with inline parameters passed to variables using commandline
   ```
      ansible-playbook -i hosts deploy-node-inline-vars.yaml -e "linux_name=tony version=1.0.0 location=/home/my-ansible-project/nodejs"
   '''
7. To run a playbook which has reference to external variables file
   ```
      ansible-playbook -i hosts deploy-node-ext-vars.yaml
   ```

       
