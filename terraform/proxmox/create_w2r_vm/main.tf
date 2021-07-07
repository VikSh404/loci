terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = "2.7.1"
    }
  }
}
provider "proxmox" {
    pm_tls_insecure = true
    pm_api_url = "https://10.1.2.10:8006/api2/json"
}

resource "proxmox_vm_qemu" "cloudinit-node" {

  vmid = "${ 1000 + count.index}"

  count = 1
  name = "new_vm-${count.index}"
  target_node = "proxmox"
  full_clone  = true
  clone = "VM 9001"
  guest_agent_ready_timeout = 60
  agent = 1
  define_connection_info = true
  onboot = false

 disk {
    size            = "10G"
    type            = "scsi"
    storage         = "ssd"
  }

  cores = 2
  sockets = 1
  memory = 4048

  ciuser = "shdv"
  cipassword = "123"

  sshkeys = <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDVmXjP6H3elqf4afZQMtOAKSIHAnRmDAsoiL4jr6BK4ht+8TS5nkW+527NeutspdtArcje1sEViF55AXDHI02h5pWEvHcY6T1mbInmHGr2Nu8y+0LyI1LP2+T8mqbClRrp/xr6/mt8UJO2aRSId25Z4JBK7gaoVYcrwvjTPBz1gA0KdNXxxzVa3dizJObFFPrwq71/7dqTN//coUD2wxnS5v8bCAQGlS5bo4IbnxF5o+AEXbDlZxAujcsEaHnw/9U5bBbwNpswg4FHrmbGy6YKAQgO9i02oho75c1JIi58HkqRZ7zbafXcyv/Z45Hj3uwLpFvbYHwkNjOL7Dv2Dr2P
EOF

  os_type = "cloud-init"
  ipconfig0 = "ip=10.1.4.${20 + count.index}/24,gw=10.1.4.10"
  nameserver = "10.1.1.2 8.8.8.8"

  network {
      model = "virtio"
      bridge = "vmbr2"
  }

  lifecycle {
   # ignore_changes = [disk, vmid, network] #In case of destroy on importe
    prevent_destroy = true   #prohibits re-creating the server in case of a config conflict
  }

  connection {
    type     = "ssh"
    user     = "shdv"
    password = "123"
    host     = "10.1.4.20"
  }


  provisioner "remote-exec" {
   inline  = [
        "sudo hostnamectl set-hostname new.vm.com",
        "ip a"
        ]
  }  
}
