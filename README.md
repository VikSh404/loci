# Loci project
**Attempt to create DevOps's "Method of loci"**
<div>
<img src="https://miro.medium.com/max/2048/1*C0_rTw0xLJgQ_dEMGuJW2A.jpeg" width=100%>
</div>
<p><a name="top">Table of contents:</a></p>

<p><a href="infra">1 Prepare infrastructure</a></p>
<p><a href="infra_sw_vagrant">1.1 Simple way (Vagrant)</a></p>
<p><a href="infra_iw_terraform">1.2 Interested way (Terraform + Proxmox)</a></p>
<p><a href="k8s">2. Intsall k8s</a></p>
<p><a href="k8s_sw_ansible_kubeadm">2.1 Simple way (ansible + kubeadm)</a></p>
<p><a href="k8s_hw_ansible">2.2 Hard way (ansible)</a></p>

# <p><a name="#infra">Prepare infrastructure</a></p> 
# <p><a name="#infra_sw_vagrant">Simple way</a></p> 
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

# <p><a name="#infra_sw_vagrant">Interested way</a></p> 
1) Install proxmox on your server (https://proxmox.com/en/)
2) Install terraform on a local PC/MacOS (https://learn.hashicorp.com/tutorials/terraform/install-cli)
3) Run terraform tf
```bash
terraform -chdir=terraform/k8s/ init
terraform -chdir=terraform/k8s/ apply

```

# <p><a name="#k8s">Install k8s</a></p> 
# <p><a name="#k8s_sw_ansible_kubeadm">Simple way</a></p> 
## Run the ansible-playbooks:
```bash
cd ansible && ansible-playbook loci.yml

# Tips:
# Exclude unused modules:
# ansible-playbook --skip-tags 'k8s_prepare' --list-tasks  --tags 'join_nodes' loci.yml
# ansible-playbook  --tags k8s_init loci.yml
```

# <p><a name="#k8s_sw_ansible_kubeadm">Hard way</a></p> 
## Run the ansible-playbooks:

  <p><a href="#top">Go up</a></p> 
