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
