# Loci project
**Attempt to create DevOps's "Method of loci"**

And, what about this project? This project is, firstly, for me (and for everyone who wants to try to use this method for remembering). I work as DevOps Engineer, and this profession required me to remember a lot of different types of information and tools.

Before I started this project, I have tried to write my Nodepad++ with 2000+ pages, multi-man (the manual), Anki, etc. All of them weren't effective.

Now I want to create a **big multi-side project** where I use all instruments I usually use in my work.

I decided to start an open project because it forced me to write better manuals and Readme-files.

**WARNING!!!** Here you can see **NOT** best practice, but **THE WAYS** to resolve the wide specter of tasks. 
*For example, my Ansible repository isn't a good example of creating variables, naming variables, task combining. There you can find how you can do it. It is something like IKEA Catalog you can use for catching an idea.*

***P.S. This page also the manual - How to use the markdown :)***
<div>
<img src="https://miro.medium.com/max/2048/1*C0_rTw0xLJgQ_dEMGuJW2A.jpeg" width=100%>
</div>
<p><a name="top">Table of contents:</a></p>

1. <a href="#infra">Prepare infrastructure</a>
    1. <a href="#infra_sw_vagrant">Vagrant way</a>
    1. <a href="#infra_iw_terraform">Terraform + Proxmox way (CANON PATH)</a>
1. <a href="#k8s">Intsall k8s</a>
    1. <a href="#k8s_sw_ansible_kubeadm">ansible + kubeadm</a>
    1. <a href="#k8s_hw_ansible">Hard way via ansible (don't do it)</a>
    1. <a href="#k8s_Rancher">Rancher way (CANON PATH)</a>
1. Deploy our frontend + backend
1. Create HA-DB
1. Setting the monitoring system


# <p><a name="infra">Prepare infrastructure</a></p> 
## <p><a name="infra_sw_vagrant">Vagrant way</a></p> 
### Preparation.
You need to change IP-addresses, an interface name, and open keys in an ansible playbook (linux_os_useradd -> files -> ansible.pub) and inventory.

```bash
vim ansible/inventory # for IPs
vim vagrant/Vagrant # for IPs ans interfaces name
vim ansible/roles/linux_os_useradd/files/ansible.pub # for keys
```

### Create new infrastructure:
```bash
cd vagrant && vagrant up

# Tips:
# Useful for quick start:
# vagrant destroy --force
# vagrant status
```

# <p><a name="infra_iw_terraform">Terraform + Proxmox way (CANON PATH)</a></p> 
1) Install proxmox on your server (https://proxmox.com/en/)
2) Install terraform on a local PC/MacOS (https://learn.hashicorp.com/tutorials/terraform/install-cli)
3) Run terraform tf-file
```bash
terraform -chdir=terraform/proxmox/k8s/ init
terraform -chdir=terraform/proxmox/k8s/ apply
```

# <p><a name="k8s">Install k8s</a></p> 
## <p><a name="k8s_sw_ansible_kubeadm">ansible + kubeadm</a></p> 
### Run the ansible-playbooks:
Install kubectl on local machine https://kubernetes.io/docs/tasks/tools/install-kubectl-macos/
```bash
cd ansible && ansible-playbook loci.yml

# Tips:
# Exclude unused modules:
# ansible-playbook --skip-tags 'k8s_prepare' --list-tasks  --tags 'join_nodes' loci.yml
# ansible-playbook  --tags k8s_init loci.yml
```

## <p><a name="k8s_hw_ansible">Hard way via ansible (don't do it)</a></p> 
### Preparation on local machine:
* Install kubectl on local machine https://kubernetes.io/docs/tasks/tools/install-kubectl-macos/

* Install cfssl on local machine:
```bash
(brew|apt|yum) install cfssl 
```
* [Create CA](k8s/hw/README.md)

### Run the ansible-playbooks:
```bash
cd ansible && ansible-playbook loci-k8sthw.yml
```
  
# <p><a name="k8s_Rancher">Rancher way (CANON PATH)</a></p> 





  <p><a href="#top">Go up</a></p> 