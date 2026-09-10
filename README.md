# Module 15: Configuration Management with Ansible
A curated collection of Ansible notes, automation concepts, and project repositories as I build my DevOps skills.

## Notes
<details>
  <summary>Introduction to Ansible</summary>

### What is Ansible?
  Ansible is an open-source IT automation and configuration management tool that enables you to automate repetitive tasks across servers, cloud resources, containers, and network devices.
  Common use cases include:
- Server provisioning
- Application deployment
- Configuration management
- Software installation and updates
- Security patching
- System maintenance
- Infrastructure orchestration
---
### Why Use Ansible?
#### Benefits
- Automates repetitive administrative tasks
- Reduces manual effort and human errors
- Executes tasks from a central control machine
- Stores infrastructure configuration as code
- Uses simple YAML syntax that is easy to read
- Allows the same automation code to be reused across environments
- Provides consistent and repeatable deployments
- Scaling automation is easier than managing systems manually
### Common Tasks
Examples of tasks that can be automated:
- Operating system upgrades
- Server reboots
- Backup jobs
- User management
- Package installation
- Application deployment
- Docker container management
- Service monitoring and maintenance
---
### Supported Infrastructure
Ansible can manage virtually any infrastructure:
- Physical (bare-metal) servers
- Virtual machines
- Public cloud environments (AWS, Azure, GCP)
- Private clouds
- Containers
- Network devices
---

### Agentless Architecture
One of Ansible's biggest advantages is that it is **agentless**.
Unlike some automation tools, Ansible does not require special software (agents) to be installed on managed hosts.
#### Benefits
- Easy setup
- Lower maintenance overhead
- No agent upgrades
- Fewer security concerns
- Reduced system resource consumption
#### Communication Methods
- Linux/Unix: SSH
- Windows: WinRM
---
### Ansible Components
#### Modules
Modules are small programs that perform specific tasks on target systems.
Examples:
- Copy a file
- Install Nginx
- Create a user
- Start a Docker container
- Install packages

#### How Modules Work
1. Ansible connects to the target host.
2. The module is temporarily transferred.
3. The module executes its task.
4. The module returns results.
5. The temporary module is removed.

#### What is Idempotency?
Ansible modules are typically **idempotent**, meaning you can run them multiple times without causing unintended changes.
---

### YAML
Ansible configurations are written using **YAML (YAML Ain't Markup Language).**

```yaml
name: Install Nginx
hosts: webservers
become: true


tasks:
  - name: Install package
    apt:
      name: nginx
      state: present
```

### YAML Rules
- Indentation matters
- Use spaces, not tabs
- Maintain consistent formatting
- Easy for humans to read
---

### Playbooks
A Playbook is a YAML file that defines automation tasks.
- Modules = Individual actions
- Playbooks = Ordered collection of actions

#### Playbook Characteristics
- Written in YAML
- Can contain one or more plays
- Defines target hosts
- Defines tasks to run
- Supports variables and conditions
- Can be reused across different environments
---


### Variables
Variables make playbooks reusable and easier to maintain.

#### Benefits
- Avoid repeating values
- Environment-specific customization
- Improved readability
---


### Inventory
An inventory defines the hosts managed by Ansible.

### Hosts Can Be
- Physical servers
- Virtual machines
- Cloud instances
- Containers
---

### Host Grouping Strategies
A host can belong to multiple groups simultaneously.
#### Group by Location (WHERE)
- East
- West
#### Group by Function (WHAT)
- Web Servers
- Database Servers
#### Group by Environment (WHEN)
- Development
- Testing
- Production
---

### Ansible and Docker
Common Docker tasks:
- Pull Docker images
- Create containers
- Start and stop containers
- Configure networks
- Deploy applications
---

### Ansible Tower / Automation Controller
Features:
- Centralized automation management
- RBAC (Role-Based Access Control)
- Scheduling jobs
- Credential management
- Inventory management
- Team collaboration
---

### Ansible vs Puppet and Chef
- Ansible uses YAML
- Puppet uses Puppet DSL
- Chef uses Ruby DSL
- Ansible is agentless
- Puppet and Chef typically require agents
---

### SSH Configuration
#### Add a Host to Known Hosts
```bash
ssh-keyscan -H <SERVER_IP> >> ~/.ssh/known_hosts
```
#### Copy SSH Key to Managed Host
```bash
ssh-copy-id root@<SERVER_IP>
```
---

### Disable Host Key Checking (Not Recommended)

Create an `.ansible.cfg` file:

```ini
[defaults]
host_key_checking = False
```

> Production environments should generally keep host key checking enabled.
---

### Key Terms to Remember
- Control Node
- Managed Node
- Inventory
- Module
- Play
- Playbook
- Role
- Variable
- YAML


</details>
