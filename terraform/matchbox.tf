resource "matchbox_profile" "controlplanes" {
  for_each = var.masters_list
  name   = each.key
  kernel = "/assets/vmlinuz"
  initrd = [
    "/assets/initramfs.xz"
  ]
  args = [
    "initrd=initramfs.xz",
    "init_on_alloc=1",
    "slab_nomerge",
    "pti=on",
    "console=tty0",
    "console=ttyS0",
    "printk.devkmsg=on",
    "talos.platform=metal",
    "talos.config=http://192.168.3.100:8080/assets/${each.key}.yaml"
  ]
}

resource "matchbox_profile" "workers" {
  for_each = var.workers_list
  name   = each.key
  kernel = "/assets/vmlinuz"
  initrd = [
    "/assets/initramfs.xz"
  ]
  args = [
    "initrd=initramfs.xz",
    "init_on_alloc=1",
    "slab_nomerge",
    "pti=on",
    "console=tty0",
    "console=ttyS0",
    "printk.devkmsg=on",
    "talos.platform=metal",
    "talos.config=http://192.168.3.100:8080/assets/${each.key}.yaml"
  ]
}

resource "matchbox_group" "controlplanes" {
  for_each = var.masters_list
  name   = each.key
  profile = each.key
  selector = {
    mac = each.value.macaddr
  }
}

resource "matchbox_group" "workers" {
  for_each = var.workers_list
  name   = each.key
  profile = each.key
  selector = {
    mac = each.value.macaddr
  }
}
