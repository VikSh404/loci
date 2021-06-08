# Loci project
**This is hobby open project**

**Tips for cli running for display ansible variables:**
```bash
ansible localhost -m setup -a "filter=ansible_distribution"
ansible all -m setup -a 'filter=*ip*'
ansible all -m setup -a 'gather_subset=network'
```
