# Modules and Collections in Ansible

## Overview

Ansible automates tasks using **modules**, which are organized and distributed through **collections**. Understanding these components is essential for building scalable and maintainable automation.

---

## Ansible Modules

Modules are small programs that perform specific actions on managed hosts.

Examples:

- Install software packages
- Manage users and groups
- Copy files
- Start and stop services
- Create Docker containers
- Provision cloud resources

Common modules:

- `ansible.builtin.copy`
- `ansible.builtin.file`
- `ansible.builtin.user`
- `ansible.builtin.service`
- `ansible.builtin.package`

### Module Characteristics

- Focused on a single task
- Reusable across playbooks
- Typically idempotent
- Execute on target hosts
- Return structured results

---

## Finding Module Documentation

The Ansible documentation contains detailed information for every module, including:

- Parameters
- Examples
- Return values
- Requirements
- Supported platforms

Useful command:

```bash
ansible-doc <module_name>
```

Example:

```bash
ansible-doc ansible.builtin.copy
```

---

## What is a Collection?

A collection is a packaging format used to bundle and distribute Ansible content.

A collection can contain:

- Modules
- Plugins
- Roles
- Playbooks
- Documentation
- Custom content

### Benefits of Collections

- Independent release cycles
- Easier dependency management
- Better organization for large projects
- Simplified content sharing

---

## Ansible Plugins

Plugins extend Ansible's functionality.

Examples include:

- Connection plugins
- Inventory plugins
- Callback plugins
- Lookup plugins
- Filter plugins

### Key Points

- Plugins add features beyond standard modules.
- Organizations can create custom plugins.
- Plugins help integrate Ansible with external systems.

---

## Ansible Galaxy

Ansible Galaxy is the community hub for discovering and sharing Ansible content.

It provides:

- Collections
- Roles
- Community-contributed content
- Vendor-supported automation content

### Install a Collection

```bash
ansible-galaxy collection install <namespace.collection>
```

Example:

```bash
ansible-galaxy collection install community.docker
```

### Upgrade a Collection

```bash
ansible-galaxy collection install <namespace.collection> --upgrade
```

Example:

```bash
ansible-galaxy collection install community.docker --upgrade
```

### List Installed Collections

```bash
ansible-galaxy collection list
```

---

## Collections Structure

Collections organize related modules and plugins into a single package.

Typical structure:

```text
collection/
├── docs/
├── plugins/
├── roles/
├── playbooks/
├── tests/
└── galaxy.yml
```

### galaxy.yml

Every collection requires a `galaxy.yml` file located at the collection root.

This file contains metadata such as:

- Collection name
- Namespace
- Version
- Author information
- Dependencies
- Description

---

## Creating Your Own Collection

Collections are useful for:

- Enterprise automation
- Large Ansible projects
- Distributing reusable content
- Team collaboration

Benefits:

- Consistent project organization
- Easier maintenance
- Version control of automation assets

---

## Namespaces and FQCN

Modern Ansible content uses the Fully Qualified Collection Name (FQCN).

Format:

```text
<namespace>.<collection>.<module>
```

or

```text
<namespace>.<collection>.<plugin>
```

### Example

```text
community.docker.docker_image
```

Breakdown:

- `community` = Namespace
- `docker` = Collection
- `docker_image` = Module

---

## What is FQCN?

FQCN stands for **Fully Qualified Collection Name**.

Examples:

```yaml
ansible.builtin.copy
community.docker.docker_container
amazon.aws.ec2_instance
```

### Why Use FQCN?

- Improves readability
- Avoids naming conflicts
- Makes playbooks future-proof
- Recommended by Ansible best practices

---

## Built-in Collections

Many modules belong to the built-in Ansible collection:

```text
ansible.builtin
```

Examples:

```yaml
ansible.builtin.copy
ansible.builtin.file
ansible.builtin.user
ansible.builtin.service
```

While Ansible often allows the short name, using the FQCN is considered a best practice.

---

## Key Terms to Remember

| Term | Description |
|------|-------------|
| Module | Performs a specific task on a managed host |
| Plugin | Extends Ansible functionality |
| Collection | Package containing modules, plugins, roles, and other content |
| Namespace | Top-level identifier for a collection |
| Galaxy | Repository for sharing and downloading Ansible content |
| FQCN | Fully Qualified Collection Name |
| galaxy.yml | Metadata file required by collections |

---

## Beginner Learning Checklist

- Understand what modules are
- Learn how collections organize Ansible content
- Use ansible-doc to explore modules
- Install collections from Galaxy
- Understand namespaces and FQCN
- Explore community.docker and amazon.aws collections
- Learn when to create custom collections
