# Automate Node.js application Deployment

## Overview
This lab demonstrates how to use **Ansible** to automate the provisioning and deployment of a **Node.js** application on a Linux server hosted on **DigitalOcean**. Instead of manually configuring the server, installing dependencies, creating users, and deploying application code, Ansible playbooks are used to define the entire process as code.

## Technologies used
* Ansible
* Node.js
* Digital Ocean (Droplet)
* Linux

## Project Description
* Create Server on DigitalOcean
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
       
