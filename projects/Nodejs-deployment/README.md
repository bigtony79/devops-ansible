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

### 4. Store the Application package
Copy the Node.js application package to a location accessible from the Ansible control node.
Example:
```
   /home/my-ansible-project/nodejs/nodejs-app-1.0.0.tgz
```

### 5. Execute Playbook Using Hardcoded Values
Run the playbook that contains all values directly within the playbook.
```
   ansible-playbook -i hosts deploy-node-no-vars.yaml
```

### 6. Execute Playbook Using Inline Variables
Run the playbook and pass variables through the command line.
```
   ansible-playbook -i hosts deploy-node-inline-vars.yaml -e "linux_name=tony version=1.0.0 location=/home/my-ansible-project/nodejs"
```

### 7. Execute Playbook Using External Variables
Run the playbook that references an external variables file.
```
   ansible-playbook -i hosts deploy-node-ext-vars.yaml
```

## Learning Outcomes
By completing this lab, you will learn how to:
* Manage remote Linux servers with Ansible
* Automate software installation and system configuration
* Configure SSH-based connectivity
* Create and manage application-specific Linux users
* Deploy Node.js applications using Ansible
* Use different approaches for handling variables in Ansible
* Build repeatable and scalable deployment processes using Infrastructure as Code (IaC)
       
