# Automate Node.js application Deployment

## Overview
This lab demonstrates how to use **Ansible** to automate the provisioning and deployment of a **Node.js** application on a Linux server hosted on **DigitalOcean**. Instead of manually configuring the server, installing dependencies, creating users, and deploying application code, Ansible playbooks are used to define the entire process as code.

## Technologies used
* Ansible
* Node.js
* Digital Ocean (Droplet)
* Linux

## Project Description
* Create Server on DigitalOcean (aka Droplet)
* Write Ansible Playbook that installs necessary technologies, creates Linux user for an application and deploys a NodeJS application with that user

## Steps
1. Provision a DigitalOcean Droplet
   - Create a Droplet
     - **Datacenter** - Choose the closest datacenter to you
     - **OS** - Select *Ubuntu* as the OS with the latest version.
     - **Droplet Type** - Select *Shared CPU - Basic* option.
     - **CPU options** - Select *Regular DiskType:SSD*
     - **Select a Plan** -   Select a low cost option which will meet your budget. For example, you can select **1vCPU-1GB RAM-25 GB SSD -1000GB Transfer** option.
   - Configure SSH keys for secure access
     - You can follow the instructions provided by DigitalOcean to generate the public and private SSH keys.
     - Save the Private Key in your ansible control node under the **user's ~/.ssh** directory
   - Select *Public IPv4 address*
   - Set the desired quantity of droplets to 1
   - Click **Create Droplet** button
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

       
