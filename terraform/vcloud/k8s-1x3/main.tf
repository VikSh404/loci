terraform {
  required_providers {
    vcd = {
      source = "vmware/vcd"
    }
  }
  required_version = ">= 0.13"
}

provider "vcd" {
  user                 = "admin"
  password             = "qefqefv3rvefv"
  auth_type            = "integrated"
  org                  = "admin"
  vdc                  = "admin"
  url                  = "https://vcloud.home.com/"
  # max_retry_timeout    = var.vcd_max_retry_timeout
  # allow_unverified_ssl = var.vcd_allow_unverified_ssl
}

# Create a new network in organization and VDC defined above
resource "vcd_network_routed" "net" {
  # ...
}


resource "vcd_vm" "TestVm" {
  name          = "TestVm"

  catalog_name  = "cat-datacloud"
  template_name = "photon-hw11"
  cpus          = 2
  memory        = 2048

  network {
    name               = "net-datacloud-r"
    type               = "org"
    ip_allocation_mode = "POOL"
  }
}