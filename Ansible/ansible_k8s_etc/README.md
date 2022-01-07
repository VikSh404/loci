# Loci project

**Tips for cli running for display ansible variables:**
```bash
ansible-playbook --skip-tags 'update' --tags k8s  loci_init.yml
ansible localhost -m setup -a "filter=ansible_distribution"
ansible all -m setup -a 'filter=*ip*'
ansible all -m setup -a 'gather_subset=network'
```
