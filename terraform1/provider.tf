provider "proxmox" {
  pm_api_url = "https://192.168.3.98:8006/api2/json"
  pm_user = "root@pam"
  pm_password = "q1w2e3r4"
  pm_tls_insecure = true
}

provider "matchbox" {
  endpoint    = var.matchbox_rpc_endpoint
  client_cert = file("../matchbox1/client.crt")
  client_key  = file("../matchbox1/client.key")
  ca          = file("../matchbox1/ca.crt")
}

terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
    }

    ct = {
      source  = "poseidon/ct"
      version = "0.11.0"
    }
    matchbox = {
      source  = "poseidon/matchbox"
      version = "0.5.2"
    }
  }
}