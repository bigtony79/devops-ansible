# Ansible Configuration: Default Inventory and Configuration Files

## Introduction

As your Ansible automation grows, it becomes important to standardize configuration and store your playbooks in a version-controlled repository.

This note covers:

- Using Git with Ansible
- Managing playbooks in source control
- Configuring a default inventory file
- Using `ansible.cfg`

---

## Using Git with Ansible

Git is one of the most important tools to use alongside Ansible.

### Why Use Git?

- Track changes to playbooks
- Maintain version history
- Enable team collaboration
- Review changes through pull requests
- Roll back to previous versions if needed
- Serve as a single source of truth for automation code

### Recommended Practice

Create a dedicated Git repository for:

- Playbooks
- Inventory files
- Roles
- Templates
- Variable files
- Documentation

Example structure:

```text
ansible-project/
├── ansible.cfg
├── inventory
├── playbooks/
├── roles/
├── group_vars/
├── host_vars/
└── README.md
```

---

## Default Inventory File

By default, Ansible expects an inventory that contains the hosts it should manage.

Without a default inventory configured, you must specify one every time you run a command.

Example:

```bash
ansible-playbook -i inventory playbook.yml
```

As projects grow, repeatedly specifying `-i` becomes inconvenient.

---

## Using ansible.cfg

Ansible configuration settings can be stored in a file called:

```text
ansible.cfg
```

This file allows you to define project-wide settings.

Example:

```ini
[defaults]
inventory = ./inventory
```

With this configuration in place, Ansible automatically uses the specified inventory file.

You can now execute:

```bash
ansible-playbook playbook.yml
```

instead of:

```bash
ansible-playbook -i inventory playbook.yml
```

---

## Example Inventory File

```ini
[webservers]
web01
web02

[databases]
db01
db02
```

After defining the inventory location in `ansible.cfg`, all playbooks in the project can use this inventory automatically.

---

## Common ansible.cfg Settings

Example:

```ini
[defaults]
inventory = ./inventory
host_key_checking = False
remote_user = ansible
forks = 10
```

### Useful Parameters

#### inventory

Sets the default inventory file.

```ini
inventory = ./inventory
```

#### remote_user

Defines the default SSH user.

```ini
remote_user = ansible
```

#### forks

Specifies how many hosts Ansible can manage in parallel.

```ini
forks = 10
```

#### host_key_checking

Controls SSH host-key verification.

```ini
host_key_checking = False
```

> For production environments, keeping host key checking enabled is generally recommended.

---

## Benefits of a Project-Specific ansible.cfg

- Consistent configuration across team members
- Reduced command-line complexity
- Easier onboarding for new contributors
- Portable automation projects
- Better maintainability

---

## Configuration File Precedence

Ansible searches for configuration files in the following order:

1. ANSIBLE_CONFIG environment variable
2. ansible.cfg in the current project directory
3. ~/.ansible.cfg
4. /etc/ansible/ansible.cfg

The first configuration file found is used.

---

## Best Practices

- Store playbooks in Git
- Commit inventory examples instead of sensitive inventory data
- Use project-level `ansible.cfg`
- Keep configuration close to the playbooks that use it
- Document required variables and inventory structure in README files
- Avoid storing secrets directly in repositories

---

## Key Terms to Remember

| Term | Description |
|------|-------------|
| Inventory | List of hosts managed by Ansible |
| ansible.cfg | Configuration file used by Ansible |
| Git Repository | Version-controlled storage for playbooks and automation code |
| Source of Truth | Authoritative location for automation artifacts |
| remote_user | Default SSH user for Ansible connections |
| forks | Number of parallel host connections |

---

## Beginner Learning Checklist

- Create a Git repository for Ansible projects
- Build a basic inventory file
- Configure a default inventory in `ansible.cfg`
- Run playbooks without using the `-i` flag
- Understand configuration file precedence
- Learn additional `ansible.cfg` settings
- Follow Git-based automation best practices
