# Loci project
# Golden image

If we want to use autocreating VM om proxmex (and we want it) we need create or download specific ***golden image*** with cloud-init.
More information about it there:
https://registry.terraform.io/providers/Telmate/proxmox/latest/docs/guides/cloud_init
https://pve.proxmox.com/wiki/Cloud-Init_Support

## Disable enterprise repo and update the hypervisor
```bash
sed -i 's/^\([^#].*\)/# \1/g' /etc/apt/sources.list.d/pve-enterprise.list

echo "deb http://download.proxmox.com/debian/pve buster pve-no-subscription" > /etc/apt/sources.list.d/pve-no-subscription.list

apt update && apt dist-upgrade -y && apt autoremove --purge -y
```

## Customize the image
```bash

apt install libvirt-tools
apt install libguestfs-tools
virt-customize --install cloud-init,atop,htop,vim,qemu-guest-agent,curl,wget -a bionic-server-cloudimg-amd64.img

```
## Create the template from the image
Run this script on proxmox-server:
```bash
chmod +x ./create_golden_image.sh
./create_golden_image.sh -i bionic-server-cloudimg-amd64.img -u 9001
```
