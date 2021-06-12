#!/bin/bash
# From https://pve.proxmox.com/wiki/Cloud-Init_Support
GOLDEN_VM_NUMBER=9000
IMAGE_NAME=bionic-server-cloudimg-amd64.img

# download the image
wget https://cloud-images.ubuntu.com/bionic/current/${IMAGE_NAME}

# create a new VM
qm create ${GOLDEN_VM_NUMBER} --memory 2048 --net0 virtio,bridge=vmbr0

# import the downloaded disk to local-lvm storage
qm importdisk ${GOLDEN_VM_NUMBER} ${IMAGE_NAME} local-lvm

# finally attach the new disk to the VM as scsi drive
qm set ${GOLDEN_VM_NUMBER} --scsihw virtio-scsi-pci --scsi0 local-lvm:vm-${GOLDEN_VM_NUMBER}-disk-0
#                                                                                                 ^ There was mistake!

# he next step is to configure a CD-ROM drive, which will be used to pass the Cloud-Init data to the VM.
qm set ${GOLDEN_VM_NUMBER} --ide2 local-lvm:cloudinit

# To be able to boot directly from the Cloud-Init image, set the bootdisk parameter to scsi0, and restrict BIOS to boot from disk only. 
# This will speed up booting, because VM BIOS skips the testing for a bootable CD-ROM.
qm set ${GOLDEN_VM_NUMBER} --boot c --bootdisk scsi0

#Also configure a serial console and use it as a display. 
# Many Cloud-Init images rely on this, as it is an requirement for OpenStack images.
qm set ${GOLDEN_VM_NUMBER} --serial0 socket --vga serial0

# In a last step, it is helpful to convert the VM into a template. 
# From this template you can then quickly create linked clones. 
# The deployment from VM templates is much faster than creating a full clone (copy).
qm template ${GOLDEN_VM_NUMBER}

