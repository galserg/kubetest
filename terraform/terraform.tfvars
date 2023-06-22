matchbox_http_endpoint = "http://192.168.3.100:8080"

matchbox_rpc_endpoint = "192.168.3.100:8081"

masters_list = {
   "cp1" = { id = "101", ipaddr = "192.168.3.101", macaddr = "12:8d:a7:33:cc:e4", target_node = "pve", system_size = "32G", system_storage = "local-lvm"}
   "cp2" = { id = "102", ipaddr = "192.168.3.102", macaddr = "12:93:4b:39:8b:e7", target_node = "pve", system_size = "32G", system_storage = "local-lvm"}
   "cp3" = { id = "103", ipaddr = "192.168.3.103", macaddr = "12:c2:e1:db:62:03", target_node = "pve", system_size = "32G", system_storage = "local-lvm"}
}

workers_list = {
   "wr1" = { id = "104", ipaddr = "192.168.3.111", macaddr = "12:f4:89:89:0a:34", target_node = "pve", system_size = "32G", system_storage = "local-lvm", local_storage = "local-lvm", local_size = "32G", data_size = "220G", data_storage = "nvg1"}
   "wr2" = { id = "105", ipaddr = "192.168.3.112", macaddr = "12:f3:66:30:06:3b", target_node = "pve", system_size = "32G", system_storage = "local-lvm", local_storage = "local-lvm", local_size = "32G", data_size = "220G", data_storage = "nvg2"}
   "wr3" = { id = "106", ipaddr = "192.168.3.113", macaddr = "12:d5:67:aa:b9:5c", target_node = "pve", system_size = "32G", system_storage = "local-lvm", local_storage = "local-lvm", local_size = "32G", data_size = "220G", data_storage = "nvg3"}
}
