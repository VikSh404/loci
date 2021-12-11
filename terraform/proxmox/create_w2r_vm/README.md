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
If necessary, you can execute commands on the remote host. With provisioner "remote-exec" it is mandatory to use connection with it.

```
  connection {
    type     = "ssh"
    user     = "root"
    password = "pass
    host     = "ip"
  }


provisioner "remote-exec" {
   inline  = [
        "sudo hostnamectl set-hostname new.vm.com",
        "ip a"
        ]
   }
```

You can also run the command on the local host.
```
  provisioner "local-exec" {
    command = "echo ${self.private_ip} >> private_ips.txt"
  }
```
