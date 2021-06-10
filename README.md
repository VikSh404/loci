# Loci project
**Attempt to create DevOps's "Method of loci"**
<div>
<img src="https://miro.medium.com/max/2048/1*C0_rTw0xLJgQ_dEMGuJW2A.jpeg" width=54%>
</div>

0) Preparation:
Change IP addresses, an interface name, and open keys in vagrant project and inventory. 
```bash
# cat ansible/inventory
# cat vagrant/Vagrant
```

1) Create new infrastructure:
```bash
cd workdir
vagrant up
```
2) Run ansible-playbooks:
```bash
cd workdir/ansible
ansible-playbook loci.yml
# Exclude unused modules
# ansible-playbook --skip-tags 'k8s_prepare' --list-tasks  --tags 'join_nodes' loci.yml
# ansible-playbook  --tags k8s_init loci.yml
```
