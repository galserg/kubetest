resource "proxmox_vm_qemu" "masters" {
    for_each = var.masters_list
    name                      = each.key
    vmid                        = each.value.id
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
        storage = each.value.system_storage
        slot = 0
        size = each.value.system_size
        cache = "none"
    }
}

resource "proxmox_vm_qemu" "workers" {
    for_each = var.workers_list
    name                      = each.key
    vmid                        = each.value.id
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
        storage = each.value.system_storage
        slot = 0
        size = each.value.system_size
        cache = "none"
    }
    disk {
        type = "virtio"
        storage = each.value.local_storage
        slot = 1
        size = each.value.local_size
        cache = "none"
    }
    disk {
        type = "virtio"
        storage = each.value.data_storage
        slot = 2
        size = each.value.data_size
        cache = "none"
    }
}