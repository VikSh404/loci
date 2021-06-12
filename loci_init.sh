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
cd workdir
terraform init
terraform apply -auto-approve
cd ansible
ansible-playbook loci.yml
elif [[ ${WAY} == 'vagrant' ]]  # don't supported 
then
cd workdir
vagrant up
cd ansible
ansible-playbook useradd_ansible.yml
ansible-playbook loci.yml 
fi
