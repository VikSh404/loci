#!/bin/bash
set -e
# example #
export PM_USER="root@pam"
export PM_PASS="rootroot"
###########
while [ -n "$1" ]
do
    case "$1" in
        -w|--way)
        WAY=$2
        shift;;
    esac
    
    shift
done

if [[ ${WAY} == 'terraform' ]]
then
terraform -chdir=terraform/proxmox/k8s/ init
terraform -chdir=terraform/proxmox/k8s/ apply -auto-approve
cd ansible
ansible-playbook loci.yml
elif [[ ${WAY} == 'vagrant' ]]  # no longer supported
then
cd vagrant
vagrant up
cd ..
cd ansible
ansible-playbook useradd_ansible.yml
ansible-playbook loci.yml
fi
