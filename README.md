# Loci project
**Attempt to create DevOps's "Method of loci"**
<div>
<img src="https://miro.medium.com/max/2048/1*C0_rTw0xLJgQ_dEMGuJW2A.jpeg" width=100%>
</div>

# Simple way
## Preparation.
Change IP-addresses, an interface name, and open keys in an ansible playbook (linux_os_useradd -> files -> ansible.pub) and inventory.

```bash
vim ansible/inventory # for IPs
vim vagrant/Vagrant # for IPs ans interfaces name
vim ansible/roles/linux_os_useradd/files/ansible.pub # for keys
```

## Create new infrastructure:
```bash
cd workdir && vagrant up

# Tips:
# Useful for quick start:
# vagrant destroy --force
# vagrant status
```
## Run ansible-playbooks:
```bash
cd workdir/ansible && ansible-playbook loci.yml

# Tips:
# Exclude unused modules:
# ansible-playbook --skip-tags 'k8s_prepare' --list-tasks  --tags 'join_nodes' loci.yml
# ansible-playbook  --tags k8s_init loci.yml
```
# Interested way
1) Install proxmox on your server (https://proxmox.com/en/)
2) Install terraform on a local PC/MacOS (https://learn.hashicorp.com/tutorials/terraform/install-cli)
3) Run terraform tf
```bash
cd workdir/terraform && terraform apply

# Tips:
# terraform destroy
```
4) Run ansible
```bash
cd workdir/ansible && ansible-playbook loci.yml

```
