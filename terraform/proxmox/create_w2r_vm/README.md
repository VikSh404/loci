Project terraform

```
terraform init
export PM_USER="root@pam/pve"
export PM_PASS="rootroot"
terraform apply
```

import 
```
terraform import proxmox_vm_qemu.name[0] pm*/vm/number_vm
example
terraform import proxmox_vm_qemu.vm[0] pm1/vm/100
```

Use the prevent_destroy parameter to prevent the deletion of the virtual machine. If you need to recreate the host to apply the settings, terraform will generate an error. Use ignore_changes to continue.
```
example

lifecycle {
    ignore_changes = [disk, vmid, network]
    prevent_destroy = true
  }
```
checking the current state of the host.
```
terraform show
```
