# Loci project
# Golden image

If we want to use autocreating VM om proxmex (and we want it) we need create or download specific ***golden image*** with cloud-init.
More information about it there:
```bash
https://registry.terraform.io/providers/Telmate/proxmox/latest/docs/guides/cloud_init
https://pve.proxmox.com/wiki/Cloud-Init_Support 
```
Run this script on proxmox-server:
```bash
chmod +x ./create_golden_image.sh
./create_golden_image.sh
```