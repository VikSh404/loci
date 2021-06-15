# Loci project
**Attempt to create DevOps's "Method of loci"**
<div>
<img src="https://miro.medium.com/max/2048/1*C0_rTw0xLJgQ_dEMGuJW2A.jpeg" width=100%>
</div>
<p><a name="top">Table of contents:</a></p>

1. <a href="#infra">Prepare infrastructure</a>
  1. <a href="#infra_sw_vagrant">Simple way (Vagrant)</a>
  1. <a href="#infra_iw_terraform">Interested way (Terraform + Proxmox)</a>
1. <a href="#k8s">Intsall k8s</a>
  1. <a href="#k8s_sw_ansible_kubeadm">Simple way (ansible + kubeadm)</a>
  1. <a href="#k8s_hw_ansible">Hard way (ansible)</a>

# <p><a name="infra">Prepare infrastructure</a></p> 
# <p><a name="infra_sw_vagrant">Simple way</a></p> 
## Preparation.
Change IP-addresses, an interface name, and open keys in an ansible playbook (linux_os_useradd -> files -> ansible.pub) and inventory.

```bash
vim ansible/inventory # for IPs
vim vagrant/Vagrant # for IPs ans interfaces name
vim ansible/roles/linux_os_useradd/files/ansible.pub # for keys
```

## Create new infrastructure:
```bash
cd vagrant && vagrant up

# Tips:
# Useful for quick start:
# vagrant destroy --force
# vagrant status
```

# <p><a name="infra_iw_terraform">Interested way</a></p> 
1) Install proxmox on your server (https://proxmox.com/en/)
2) Install terraform on a local PC/MacOS (https://learn.hashicorp.com/tutorials/terraform/install-cli)
3) Run terraform tf
```bash
terraform -chdir=terraform/k8s/ init
terraform -chdir=terraform/k8s/ apply

```

# <p><a name="k8s">Install k8s</a></p> 
# <p><a name="k8s_sw_ansible_kubeadm">Simple way</a></p> 
## Run the ansible-playbooks:
```bash
cd ansible && ansible-playbook loci.yml

# Tips:
# Exclude unused modules:
# ansible-playbook --skip-tags 'k8s_prepare' --list-tasks  --tags 'join_nodes' loci.yml
# ansible-playbook  --tags k8s_init loci.yml
```

# <p><a name="k8s_hw_ansible">Hard way</a></p> 
## Run the ansible-playbooks:

  <p><a href="#top">Go up</a></p> 
