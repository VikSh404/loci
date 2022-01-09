terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = "2.7.1"
    }
  }
}
# export PM_USER="root@pam"
# export PM_PASS="rootroot"
provider "proxmox" {
    pm_tls_insecure = true
    pm_api_url = "https://10.0.0.10:8006/api2/json"
    pm_user = "root@pam"
    pm_password = "rootroot"
}


resource "proxmox_vm_qemu" "postgresql" {

  vmid = "${ 1101 + count.index}"
    
  count = 2
  name = "postgresql-0${1 + count.index}"
  target_node = "pve"
  full_clone  = true
  clone = "CentOS-8-GenericCloud"
  guest_agent_ready_timeout = 60  
  agent = 1
  define_connection_info = true

 disk {
    #id              = "0"
    size            = "10G"
    type            = "scsi"
    storage         = "local-lvm"        
    #storage_type    = "lvm-thin"
    #valid only with virtio disk or virtio-scsi-single controller
    #iothread        = true 
  }

  cores = 2
  sockets = 2
  memory = 8128

  ciuser = "ansible"
  cipassword = "ansible"

  sshkeys = <<EOF
  ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDHoBRy6kZ4WDuDDRFjeG/tAONcvKkCoH22IHi4ZpuZDdC3cY/0svA9BWvTiNJXqrRR3SlGk61s+HbB5ruQdDPJyqUJDHwcQAvto1isEIHM5t/7JWx8vnB5SIO6AENF+xm37aZO3F/IJ/ATTRwJhKPEpgd+vFRq0+A7ww4iCtEHiqXLunJ1pNmyKI4oDMfMHrvxJAcQoaCLFuAr+1GxtxbLpFbIePrD2eC2YSFzF0ivpxZn7aa4ZLv4IP5qBv6gN59TiKmoX8jvcVo1IAVyZsbVBj4ArhNatXaOl0y5Xtfcds6IKu4WWMHFf8YE0EPWLmeliWFrFNNKPLgdIPZCgrw7JhCuhQiKi1aQLrQ4sCV1UyXtPeA5AWa7Qtpu5GJ99w3O5ck8Ry79p2kAe9zDCkzAp8ziy2HzFiPh3kn4kaHMmEgI800j9uxGqlfqlD5h5PDTP6jUSjQkriVOx3lMnyM+JKun4GCAl9XoGv3gwkyitj5I8z1kw+a+6HN6CjejkME= viktorshevchenko@MacBook-Air-Viktor.local
  ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC9eobD+jlofc6ZInJhgHgQgIMdfCo4TG9DwqqL4uXW/g0XqBQMDRS04/qoLKVnOVAhrOemThM2ZUywCcTwWHdhZCb93/7NwrwI4hDiktkwVb+khXG8tD3GXlkI1K9PzCuwf9rwfMcXPy4WKBJHdwMsRejnXXwzXReF5qcy3jvM4E+Puf9tlZWUEmSfF9/I9Je+rUESd+d58E7n6HIOb/leZ/+a7no9rQnqrlofVR2bQ5ldVBcC0BhOI1a11XMnjo5AODfUzLNeNKuYNErnneCO6Igy2oi6A8nSHR380U0ITJkJH/8frYbqTCIV1+dTWxSRsTdVNiJ2PHNlauynn0Qv mrv@mrv-MS-7B86
  ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC4OBbeswQ3aF4t2W9VdKEiciDYLBnOAcItVmTOrLQoHDkDYzxqY8KdQP8ZLXrEHf4KKWFj8CObbZS1gUBa5IefSr9oVD0hBDBSk+5BHZBi9pjKKXviYq33EPTYAN2qhsOgN346zoUCTnEIruLoLpfFbpJlLnSklqQR+XR1kiUv+s1tuPcy7N8pivN70NC8JotMhDw1QawEv9cHVEvrW+1KiYBrQmTTigxD9t+37W13h85ZParacr2P4JXnGVsCzZRD8E+z7Y6AiNNEnQdRWywwF0cpOxqUNvWDzKtUEUyUA0cghJr+4GgncXa2csynMqNoUs3i4Wo4aDgeTL8oNtgz ansible@mrv-MS-7B86
  EOF

  os_type = "cloud-init"
  ipconfig0 = "ip=10.0.0.${101 + count.index}/24,gw=10.0.0.138"
  #nameserver = "192.168.88.99"

 }



resource "proxmox_vm_qemu" "haproxy" {

  vmid = "${ 1103 + count.index}"
    
  count = 2
  name = "haproxy-0${1 + count.index}"
  target_node = "pve"
  full_clone  = true
  clone = "CentOS-8-GenericCloud"
  guest_agent_ready_timeout = 60  
  agent = 1
  define_connection_info = true

 disk {
    #id              = "0"
    size            = "10G"
    type            = "scsi"
    storage         = "local-lvm"        
    #storage_type    = "lvm-thin"
    #valid only with virtio disk or virtio-scsi-single controller
    #iothread        = true 
  }

  cores = 2
  sockets = 2
  memory = 2048

  ciuser = "ansible"
  cipassword = "ansible"

  sshkeys = <<EOF
  ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDHoBRy6kZ4WDuDDRFjeG/tAONcvKkCoH22IHi4ZpuZDdC3cY/0svA9BWvTiNJXqrRR3SlGk61s+HbB5ruQdDPJyqUJDHwcQAvto1isEIHM5t/7JWx8vnB5SIO6AENF+xm37aZO3F/IJ/ATTRwJhKPEpgd+vFRq0+A7ww4iCtEHiqXLunJ1pNmyKI4oDMfMHrvxJAcQoaCLFuAr+1GxtxbLpFbIePrD2eC2YSFzF0ivpxZn7aa4ZLv4IP5qBv6gN59TiKmoX8jvcVo1IAVyZsbVBj4ArhNatXaOl0y5Xtfcds6IKu4WWMHFf8YE0EPWLmeliWFrFNNKPLgdIPZCgrw7JhCuhQiKi1aQLrQ4sCV1UyXtPeA5AWa7Qtpu5GJ99w3O5ck8Ry79p2kAe9zDCkzAp8ziy2HzFiPh3kn4kaHMmEgI800j9uxGqlfqlD5h5PDTP6jUSjQkriVOx3lMnyM+JKun4GCAl9XoGv3gwkyitj5I8z1kw+a+6HN6CjejkME= viktorshevchenko@MacBook-Air-Viktor.local
  ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC9eobD+jlofc6ZInJhgHgQgIMdfCo4TG9DwqqL4uXW/g0XqBQMDRS04/qoLKVnOVAhrOemThM2ZUywCcTwWHdhZCb93/7NwrwI4hDiktkwVb+khXG8tD3GXlkI1K9PzCuwf9rwfMcXPy4WKBJHdwMsRejnXXwzXReF5qcy3jvM4E+Puf9tlZWUEmSfF9/I9Je+rUESd+d58E7n6HIOb/leZ/+a7no9rQnqrlofVR2bQ5ldVBcC0BhOI1a11XMnjo5AODfUzLNeNKuYNErnneCO6Igy2oi6A8nSHR380U0ITJkJH/8frYbqTCIV1+dTWxSRsTdVNiJ2PHNlauynn0Qv mrv@mrv-MS-7B86
  ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC4OBbeswQ3aF4t2W9VdKEiciDYLBnOAcItVmTOrLQoHDkDYzxqY8KdQP8ZLXrEHf4KKWFj8CObbZS1gUBa5IefSr9oVD0hBDBSk+5BHZBi9pjKKXviYq33EPTYAN2qhsOgN346zoUCTnEIruLoLpfFbpJlLnSklqQR+XR1kiUv+s1tuPcy7N8pivN70NC8JotMhDw1QawEv9cHVEvrW+1KiYBrQmTTigxD9t+37W13h85ZParacr2P4JXnGVsCzZRD8E+z7Y6AiNNEnQdRWywwF0cpOxqUNvWDzKtUEUyUA0cghJr+4GgncXa2csynMqNoUs3i4Wo4aDgeTL8oNtgz ansible@mrv-MS-7B86
  EOF

  os_type = "cloud-init"
  ipconfig0 = "ip=10.0.0.${103 + count.index}/24,gw=10.0.0.138"
  #nameserver = "192.168.88.99"

 }



resource "proxmox_vm_qemu" "barman" {

  vmid = "${ 1105 + count.index}"
    
  count = 1
  name = "barman-0${1 + count.index}"
  target_node = "pve"
  full_clone  = true
  clone = "CentOS-8-GenericCloud"
  guest_agent_ready_timeout = 60  
  agent = 1
  define_connection_info = true

 disk {
    #id              = "0"
    size            = "40G"
    type            = "scsi"
    storage         = "local-lvm"        
    #storage_type    = "lvm-thin"
    #valid only with virtio disk or virtio-scsi-single controller
    #iothread        = true 
  }

  cores = 2
  sockets = 2
  memory = 2048

  ciuser = "ansible"
  cipassword = "ansible"

  sshkeys = <<EOF
  ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDHoBRy6kZ4WDuDDRFjeG/tAONcvKkCoH22IHi4ZpuZDdC3cY/0svA9BWvTiNJXqrRR3SlGk61s+HbB5ruQdDPJyqUJDHwcQAvto1isEIHM5t/7JWx8vnB5SIO6AENF+xm37aZO3F/IJ/ATTRwJhKPEpgd+vFRq0+A7ww4iCtEHiqXLunJ1pNmyKI4oDMfMHrvxJAcQoaCLFuAr+1GxtxbLpFbIePrD2eC2YSFzF0ivpxZn7aa4ZLv4IP5qBv6gN59TiKmoX8jvcVo1IAVyZsbVBj4ArhNatXaOl0y5Xtfcds6IKu4WWMHFf8YE0EPWLmeliWFrFNNKPLgdIPZCgrw7JhCuhQiKi1aQLrQ4sCV1UyXtPeA5AWa7Qtpu5GJ99w3O5ck8Ry79p2kAe9zDCkzAp8ziy2HzFiPh3kn4kaHMmEgI800j9uxGqlfqlD5h5PDTP6jUSjQkriVOx3lMnyM+JKun4GCAl9XoGv3gwkyitj5I8z1kw+a+6HN6CjejkME= viktorshevchenko@MacBook-Air-Viktor.local
  ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC9eobD+jlofc6ZInJhgHgQgIMdfCo4TG9DwqqL4uXW/g0XqBQMDRS04/qoLKVnOVAhrOemThM2ZUywCcTwWHdhZCb93/7NwrwI4hDiktkwVb+khXG8tD3GXlkI1K9PzCuwf9rwfMcXPy4WKBJHdwMsRejnXXwzXReF5qcy3jvM4E+Puf9tlZWUEmSfF9/I9Je+rUESd+d58E7n6HIOb/leZ/+a7no9rQnqrlofVR2bQ5ldVBcC0BhOI1a11XMnjo5AODfUzLNeNKuYNErnneCO6Igy2oi6A8nSHR380U0ITJkJH/8frYbqTCIV1+dTWxSRsTdVNiJ2PHNlauynn0Qv mrv@mrv-MS-7B86
  ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC4OBbeswQ3aF4t2W9VdKEiciDYLBnOAcItVmTOrLQoHDkDYzxqY8KdQP8ZLXrEHf4KKWFj8CObbZS1gUBa5IefSr9oVD0hBDBSk+5BHZBi9pjKKXviYq33EPTYAN2qhsOgN346zoUCTnEIruLoLpfFbpJlLnSklqQR+XR1kiUv+s1tuPcy7N8pivN70NC8JotMhDw1QawEv9cHVEvrW+1KiYBrQmTTigxD9t+37W13h85ZParacr2P4JXnGVsCzZRD8E+z7Y6AiNNEnQdRWywwF0cpOxqUNvWDzKtUEUyUA0cghJr+4GgncXa2csynMqNoUs3i4Wo4aDgeTL8oNtgz ansible@mrv-MS-7B86
  EOF

  os_type = "cloud-init"
  ipconfig0 = "ip=10.0.0.${105 + count.index}/24,gw=10.0.0.138"
  #nameserver = "192.168.88.99"

 }
