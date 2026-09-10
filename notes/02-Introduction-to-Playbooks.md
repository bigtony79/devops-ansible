# Introduction to Ansible Playbooks

## What is a Playbook?

A playbook is a YAML file that defines a series of automation tasks to be executed by Ansible.

Think of a playbook as a set of instructions that Ansible follows to configure, deploy, or manage systems.

### Key Characteristics

- Written in YAML
- Defines automation as code
- Can be version controlled using Git
- Easy to read and maintain
- Reusable across multiple environments

---

## Plays vs Tasks

### Play

A **play** defines:

- Which hosts to target
- Which tasks to execute
- Which user privileges to use

### Task

A **task** is a single action performed using an Ansible module.

Examples:

- Install a package
- Copy a file
- Create a user
- Start a service

---

## Playbook Structure

A playbook can contain one or more plays.

Example:

```yaml
---
- name: Configure Database Servers
  hosts: databases

  tasks:
    - name: Install MySQL
      apt:
        name: mysql-server
        state: present

- name: Configure Web Servers
  hosts: webservers

  tasks:
    - name: Install Nginx
      apt:
        name: nginx
        state: present
```

In this example:

- Play 1 targets database servers
- Play 2 targets web servers
- Both plays are stored in the same playbook

---

## Executing a Playbook

To execute a playbook:

```bash
ansible-playbook -i <inventory_file> <playbook_file>
```

Example:

```bash
ansible-playbook -i inventory.ini install-nginx.yml
```

### Common Options

Run in check mode (dry run):

```bash
ansible-playbook -i inventory.ini playbook.yml --check
```

Display differences before making changes:

```bash
ansible-playbook -i inventory.ini playbook.yml --diff
```

Prompt for sudo password:

```bash
ansible-playbook -i inventory.ini playbook.yml --ask-become-pass
```

---

## Gather Facts

By default, Ansible automatically runs the **Gather Facts** task at the beginning of each play.

This uses the **setup** module to collect information about target systems.

Example output includes:

- Hostname
- IP address
- Operating system
- Distribution version
- CPU information
- Memory information
- Network interfaces

Example:

```yaml
- name: Display OS Information
  hosts: all

  tasks:
    - name: Show OS
      debug:
        msg: "{{ ansible_distribution }}"
```

### Useful Facts

```yaml
{{ ansible_hostname }}
{{ ansible_distribution }}
{{ ansible_distribution_version }}
{{ ansible_default_ipv4.address }}
{{ ansible_processor_cores }}
```

### Disable Fact Gathering

```yaml
---
- name: Simple Play
  hosts: all
  gather_facts: false

  tasks:
    - name: Ping host
      ping:
```

---

## Ansible Idempotency

One of Ansible's most important concepts is **idempotency**.

### What is Idempotency?

A task can be executed multiple times and still produce the same result without causing unintended changes.

### Example

```yaml
- name: Install Nginx
  apt:
    name: nginx
    state: present
```

First execution:

```text
changed=1
```

Second execution:

```text
changed=0
```

---

## Benefits of Idempotency

- Safe to execute repeatedly
- Reduces configuration drift
- Prevents duplicate changes
- Makes automation predictable
- Helps maintain consistent environments

---

## Playbook Best Practices

### Use Descriptive Names

```yaml
- name: Install Nginx Web Server
```

### Keep Tasks Small

Each task should perform a single action.

### Use Variables

```yaml
vars:
  web_package: nginx
```

### Group Similar Tasks

Organize related tasks into plays and roles.

---

## Playbook Execution Flow

1. Read the inventory file.
2. Identify target hosts.
3. Gather facts (unless disabled).
4. Execute tasks in order.
5. Return results.
6. Display a summary.

Example summary:

```text
PLAY RECAP

web01 : ok=5 changed=2 unreachable=0 failed=0
db01  : ok=4 changed=1 unreachable=0 failed=0
```

---

## Key Terms to Remember

| Term | Description |
|--------|-------------|
| Playbook | YAML file containing one or more plays |
| Play | Group of tasks executed against hosts |
| Task | Single action performed by a module |
| Module | Reusable unit of work such as apt, copy, service |
| Gather Facts | Automatic collection of host information |
| Setup Module | Module used to collect facts |
| Idempotency | Ability to run repeatedly without unwanted changes |
| Inventory | List of hosts managed by Ansible |

---

## Beginner Learning Checklist

- Understand the structure of a playbook
- Learn the difference between plays and tasks
- Execute playbooks from the command line
- Use gathered facts in playbooks
- Understand idempotency
- Interpret play recap results
- Start building reusable playbooks with variables

