resource "local_file" "docker_compose" {
  filename = "../docker/docker-compose.yaml"
  content  = templatefile("docker-compose.tftpl", { masters = var.masters_list,  workers = var.workers_list})
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