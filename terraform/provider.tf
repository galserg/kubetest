provider "proxmox" {
  pm_api_url = "https://192.168.3.99:8006/api2/json"
  pm_user = "root@pam"
  pm_password = "q1w2e3r4"
  pm_tls_insecure = true
}

terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
    }
  }
}