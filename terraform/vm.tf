variable "masters_list" {
  description = "Masters list"
  default = {
   "cp1" = { ipaddr = "192.168.3.101", macaddr = "12:2a:01:45:7b:51" },
   "cp2" = { ipaddr = "192.168.3.102", macaddr = "12:2f:a3:e2:2b:c2" },
   "cp3" = { ipaddr = "192.168.3.103", macaddr = "12:8d:e0:b1:40:58" }
  }
}

variable "workers_list" {
  description = "Workers list"
  default = {
   "wr1" = { ipaddr = "192.168.3.111", macaddr = "12:27:b3:fc:30:b7" },
   "wr2" = { ipaddr = "192.168.3.112", macaddr = "12:93:49:d7:5f:c4" },
   "wr3" = { ipaddr = "192.168.3.113", macaddr = "12:5a:58:55:bc:27" }
  }
}
resource "local_file" "docker_compose" {
  filename = "../docker/docker-compose.yaml"
  content  = templatefile("masters.tftpl", { masters = var.masters_list,  workers = var.workers_list})
}

resource "local_file" "master_config" {
  for_each = var.masters_list
  filename = "../config/${each.key}.yaml"
  content  = templatefile("controlplane.tftpl", { ipaddr = each.value.ipaddr,  hostname = each.key})
}

resource "local_file" "workers_config" {
  for_each = var.workers_list
  filename = "../config/${each.key}.yaml"
  content  = templatefile("worker.tftpl", { ipaddr = each.value.ipaddr,  hostname = each.key})
}