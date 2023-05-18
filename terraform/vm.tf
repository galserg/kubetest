resource "proxmox_vm_qemu" "masters" {
    for_each = var.masters_list
    name                      = each.key
    agent                     = 0
    boot                      = "order=virtio0;net0"
    onboot                    = true
    pxe                       = true
    target_node               = "pve"
    memory                    = 4096
    cores                     = 2
    scsihw                    = "virtio-scsi-pci"
    qemu_os                   = "l26"
    network {
        bridge    = "vmbr0"
        firewall  = false
        link_down = false
        model     = "virtio"
        macaddr   = each.value.macaddr
    }
    disk {
        type = "virtio"
        storage = "ssd"
        slot = 0
        size = "32G"
        cache = "none"
    }
}

resource "proxmox_vm_qemu" "workers" {
    for_each = var.workers_list
    name                      = each.key
    agent                     = 0
    boot                      = "order=virtio0;net0"
    onboot                    = true
    pxe                       = true
    target_node               = "pve"
    memory                    = 16384
    cores                     = 4
    scsihw                    = "virtio-scsi-pci"
    qemu_os                   = "l26"
    network {
        bridge    = "vmbr0"
        firewall  = false
        link_down = false
        model     = "virtio"
        macaddr   = each.value.macaddr
    }
    disk {
        type = "virtio"
        storage = "ssd"
        slot = 0
        size = "32G"
        cache = "none"
    }
    disk {
        type = "virtio"
        storage = "local-lvm"
        slot = 1
        size = "48G"
        cache = "none"
    }
    disk {
        type = "virtio"
        storage = "local-lvm"
        slot = 2
        size = "48G"
        cache = "none"
    }
}