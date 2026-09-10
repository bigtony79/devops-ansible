# Ansible Variables: Make Your Playbooks Customizable

## Introduction

Variables allow you to make Ansible playbooks flexible, reusable, and easier to maintain.

Instead of hardcoding values, variables enable you to customize behavior for different environments, applications, and deployments.

---

## Using Variables in Ansible

Variables are referenced using Jinja2 syntax:

```yaml
{{ variable_name }}
```

Example:

```yaml
app_version: 1.0.0

src: "nodejs-app-{{ app_version }}.tgz"
```

### Important Note

If a value starts with a variable expression, quote the entire string to ensure valid YAML syntax.

Good:

```yaml
src: "{{ location }}/app.tgz"
```

---

## Register Variables

The `register` keyword stores the output of a task in a variable.

Example:

```yaml
---
- name: Verify Node.js and npm Installation
  hosts: all

  tasks:
    - name: Check Node.js version
      command: node -v
      register: node_version

    - name: Check npm version
      command: npm -v
      register: npm_version

    - name: Display Node.js and npm versions
      debug:
        msg: "Node.js version: {{ node_version.stdout }}, npm version: {{ npm_version.stdout }}"
```

### Common Registered Variable Attributes

```yaml
stdout
stderr
stdout_lines
rc
changed
failed
```

---

## Variables Defined in a Playbook

Variables can be declared using the `vars` section.

Example:

```yaml
---
- name: Deploy Node.js Application
  hosts: all
  become: true
  become_user: nodeapp

  vars:
    location: /home/my-ansible-project/nodejs
    version: 1.0.0
    destination: /home/nodeapp

  tasks:
    - name: Unpack Node.js archive
      unarchive:
        src: "{{ location }}/nodejs-app-{{ version }}.tgz"
        dest: "{{ destination }}"
        remote_src: yes

    - name: Install application dependencies
      npm:
        path: "{{ destination }}/package"

    - name: Start Node.js application
      command: node {{ destination }}/package/app/server
      async: 300
      poll: 0

    - name: Verify application is running
      shell: ps aux | grep node | grep -v grep
      register: app_status

    - name: Display application status
      debug:
        msg: "Node.js application response: {{ app_status.stdout_lines }}"
```

---

## Built-in Ansible Keywords

### become

Run tasks with elevated privileges.

```yaml
become: true
```

### become_user

Run tasks as a different user.

```yaml
become_user: nodeapp
```

### vars

Define variables that are available throughout the playbook.

```yaml
vars:
  version: 1.0.0
```

---

## Passing Variables on the Command Line

Variables can be supplied when executing a playbook.

```bash
ansible-playbook -i hosts deploy-node.yaml -e "version=1.0.0 location=/home/nodeapp/nodejs-app"
```

The `-e` option stands for:

```text
--extra-vars
```

Benefits:

- Override default values
- Use the same playbook across environments
- Avoid modifying playbook source code

---

## External Variable Files

For larger projects, managing many command-line variables becomes difficult.

A separate variable file can be used.

Example file:

```yaml
# vars.yaml
version: 1.0.0
location: /home/my-ansible-project/nodejs
destination: /home/nodeapp
```

Load the file:

```bash
ansible-playbook -i hosts deploy-node.yaml -e @vars.yaml
```

Benefits:

- Cleaner playbooks
- Easier maintenance
- Better organization
- Environment-specific configurations

---

## Variable Precedence

When the same variable is defined in multiple locations, Ansible follows a precedence order.

Simplified order:

1. Extra variables (`-e`)
2. Playbook variables (`vars`)
3. Inventory variables
4. Role defaults

In general, command-line variables have the highest priority.

---

## Inventory Variables

Variables can also be assigned to hosts and groups.

Example:

```ini
[webservers]
web01 app_port=8080
web02 app_port=8081
```

Group variables:

```ini
[webservers:vars]
app_name=nodejs-app
```

---

## Variable Naming Best Practices

Use meaningful names:

```yaml
app_version
app_location
database_host
```

Avoid:

```yaml
v1
x
data
```

Guidelines:

- Use lowercase letters
- Use underscores
- Choose descriptive names
- Maintain naming consistency

---

## Key Terms to Remember

| Term | Description |
|------|-------------|
| Variable | Reusable value used in a playbook |
| Jinja2 | Templating syntax used by Ansible |
| register | Stores task output in a variable |
| vars | Defines variables in a playbook |
| extra-vars | Variables passed at runtime using `-e` |
| stdout | Standard output of a command |
| stdout_lines | Output returned as a list of lines |
| Variable File | External YAML file containing variables |

---

## Beginner Learning Checklist

- Understand Jinja2 variable syntax
- Use variables inside tasks
- Register command output
- Access stdout and stdout_lines
- Pass variables through the command line
- Create external variable files
- Learn inventory variables
- Understand variable precedence
