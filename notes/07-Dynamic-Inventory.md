# Dynamic Inventory for EC2 Servers

## Introduction

In traditional Ansible environments, inventories are often managed manually using static host files.

This approach becomes difficult in cloud environments where servers are frequently created, terminated, or replaced.

Dynamic Inventory solves this problem by allowing Ansible to discover infrastructure automatically.

---

## Why Dynamic Inventory?

Dynamic inventory is useful when infrastructure changes frequently.

Common scenarios include:

- Auto Scaling Groups
- Cloud-native applications
- Development and testing environments
- Ephemeral infrastructure
- Kubernetes worker nodes
- CI/CD environments

### Challenges with Static Inventories

- Manual inventory maintenance
- Outdated IP addresses
- Servers being created and destroyed frequently
- Increased operational overhead

For example:

```text
EC2 Instance Created
       ↓
New Public IP Assigned
       ↓
Inventory File Becomes Outdated
       ↓
Ansible Cannot Connect
```

Hard-coding IP addresses is generally not recommended for cloud-based infrastructure.

---

## Dynamic Inventory Approaches

### Dynamic Inventory Scripts

Older versions of Ansible commonly used custom scripts.

Characteristics:

- Written in Python, Bash, or other languages
- Query cloud provider APIs
- Generate inventory dynamically

Drawbacks:

- More difficult to maintain
- Additional coding effort
- Custom state management

---

### Dynamic Inventory Plugins

Ansible now recommends using Dynamic Inventory Plugins.

Benefits:

- Native Ansible support
- Easier configuration
- YAML-based configuration
- Better scalability
- Built-in integration with cloud providers
- Simplified maintenance

Popular inventory plugins include:

- aws_ec2
- azure_rm
- gcp_compute
- kubernetes
- vmware_vm_inventory

---

# AWS EC2 Inventory Plugin

The AWS EC2 Inventory Plugin automatically discovers EC2 instances using AWS APIs.

Typical use cases:

- Discover EC2 instances automatically
- Group hosts by tags
- Group hosts by regions
- Group hosts by instance types
- Remove the need for static inventories

---

## Example Inventory Plugin Configuration

```yaml
# inventory_aws_ec2.yaml
plugin: amazon.aws.aws_ec2
regions:
  - us-east-1

keyed_groups:
  - key: tags.Name
    prefix: tag

hostnames:
  - dns-name
```

---

## Viewing Inventory Details

To display the complete inventory information:

```bash
ansible-inventory -i inventory_aws_ec2.yaml --list
```

This command returns a large JSON document containing:

- Host variables
- Instance IDs
- Public DNS names
- Tags
- Instance types
- AMI information
- Security configuration
- Networking metadata

Example output fields:

```json
{
  "instance_id": "i-05c61a7d65e9c8cca",
  "instance_type": "t3.micro",
  "image_id": "ami-02b3d83d84b07786d",
  "key_name": "dev-keypair",
  "ec2_tags": {
    "Name": "dev-server-3"
  }
}
```

---

## Viewing Hosts Only

To display a simplified inventory tree:

```bash
ansible-inventory -i inventory_aws_ec2.yaml --graph
```

Example:

```text
@all:
|--@ungrouped:
|--@aws_ec2:
|  |--ec2-34-207-138-219.compute-1.amazonaws.com
|  |--ec2-54-162-31-115.compute-1.amazonaws.com
|  |--ec2-34-201-139-238.compute-1.amazonaws.com
|  |--ec2-3-85-88-97.compute-1.amazonaws.com
```

This view is easier to read because it focuses on hosts and groups rather than all instance metadata.

---

## Benefits of Dynamic Inventory

### Automatic Discovery

New EC2 instances are discovered without modifying inventory files.

### Reduced Maintenance

No need to manually add or remove hosts.

### Better Cloud Integration

Inventory automatically reflects the current AWS environment.

### Tag-Based Grouping

Hosts can be grouped using EC2 tags.

Example:

```yaml
keyed_groups:
  - key: tags.Environment
    prefix: env
```

Resulting groups:

```text
env_dev
env_test
env_prod
```

---

## Common Inventory Commands

### Validate Inventory

```bash
ansible-inventory -i inventory_aws_ec2.yaml --list
```

### Display Host Graph

```bash
ansible-inventory -i inventory_aws_ec2.yaml --graph
```

### View Specific Host Variables

```bash
ansible-inventory -i inventory_aws_ec2.yaml --host <hostname>
```

### Ping All Hosts

```bash
ansible all -i inventory_aws_ec2.yaml -m ping
```

---

## Best Practices

- Use inventory plugins instead of custom scripts
- Organize EC2 instances with tags
- Avoid hard-coded IP addresses
- Use IAM roles with least-privilege access
- Group hosts by environment and application
- Store inventory configuration in Git
- Test inventory changes using `ansible-inventory --graph`

---

## Key Terms to Remember

| Term | Description |
|------|-------------|
| Dynamic Inventory | Inventory generated automatically from external systems |
| Inventory Plugin | Built-in Ansible mechanism for inventory discovery |
| aws_ec2 | AWS EC2 inventory plugin |
| Static Inventory | Manually maintained host file |
| Hostvars | Variables associated with a host |
| EC2 Tags | Metadata used for grouping and filtering hosts |
| ansible-inventory | Command for inspecting inventory information |

---

## Beginner Learning Checklist

- Understand static vs dynamic inventory
- Configure the AWS EC2 inventory plugin
- Use ansible-inventory commands
- Explore host variables
- Group hosts using EC2 tags
- Run playbooks against dynamically discovered hosts
- Integrate dynamic inventory with Terraform-provisioned infrastructure
