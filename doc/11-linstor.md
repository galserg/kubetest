Для нодселектора надо добавить лейблы в мешинконфиг
но пока руками
```
kubectl label nodes wr1 piraeus=true
kubectl label nodes wr2 piraeus=true
kubectl label nodes wr3 piraeus=true
kubectl get nodes --show-labels
```
nodeselector прописывается не в чарте, а в CRD LinstorCluster
```
kubectl -f hack/linstor/linstor-cfg.yaml apply
kubectl -f hack/linstor/cluster.yaml apply
kubectl -f hack/linstor/pool.yaml apply
kubectl -f hack/linstor/class.yaml apply
kubectl -f hack/linstor/pvc.yaml apply
```

смотрим что получилось

```
kubectl -n piraeus-datastore exec deploy/linstor-controller -- linstor node list
+-------------------------------------------------------+
| Node | NodeType  | Addresses                 | State  |
|=======================================================|
| wr1  | SATELLITE | 10.244.2.113:3366 (PLAIN) | Online |
| wr2  | SATELLITE | 10.244.4.20:3366 (PLAIN)  | Online |
| wr3  | SATELLITE | 10.244.0.147:3366 (PLAIN) | Online |
+-------------------------------------------------------+

kubectl -n piraeus-datastore exec deploy/linstor-controller -- linstor storage-pool list
+----------------------------------------------------------------------------------------------------------------------+
| StoragePool          | Node | Driver   | PoolName | FreeCapacity | TotalCapacity | CanSnapshots | State | SharedName |
|======================================================================================================================|
| DfltDisklessStorPool | wr1  | DISKLESS |          |              |               | False        | Ok    |            |
| DfltDisklessStorPool | wr2  | DISKLESS |          |              |               | False        | Ok    |            |
| DfltDisklessStorPool | wr3  | DISKLESS |          |              |               | False        | Ok    |            |
| vdc-pool             | wr1  | LVM      | vdc-vg   |    48.00 GiB |     48.00 GiB | False        | Ok    |            |
| vdc-pool             | wr2  | LVM      | vdc-vg   |    48.00 GiB |     48.00 GiB | False        | Ok    |            |
| vdc-pool             | wr3  | LVM      | vdc-vg   |    48.00 GiB |     48.00 GiB | False        | Ok    |            |
+----------------------------------------------------------------------------------------------------------------------+

kubectl -n piraeus-datastore exec deploy/linstor-controller -- linstor resource list-volumes
+---------------------------------------------------------------------------------------------------------------------------------+
| Node | Resource                                 | StoragePool | VolNr | MinorNr | DeviceName    | Allocated | InUse  |    State |
|=================================================================================================================================|
| wr1  | pvc-14861f11-ccf8-489a-b2a9-df0c66017473 | vdc-pool    |     0 |    1000 | /dev/drbd1000 |  1.00 GiB | Unused | UpToDate |
| wr2  | pvc-14861f11-ccf8-489a-b2a9-df0c66017473 | vdc-pool    |     0 |    1000 | /dev/drbd1000 |  1.00 GiB | InUse  | UpToDate |
| wr3  | pvc-14861f11-ccf8-489a-b2a9-df0c66017473 | vdc-pool    |     0 |    1000 | /dev/drbd1000 |  1.00 GiB | Unused | UpToDate |
+---------------------------------------------------------------------------------------------------------------------------------+

```


TODO. не получилось с LVM_THIN
не создается пул автоматом? должен указывать на существующий обычный лвм (пробовал!)

Для тестирования скорости
```
kubectl label ns default pod-security.kubernetes.io/enforce=privileged pod-security.kubernetes.io/audit=privileged pod-security.kubernetes.io/warn=privileged
kubectl apply -f https://raw.githubusercontent.com/openebs/Mayastor/v1.0.2/deploy/fio.yaml
kubectl exec -it fio -- fio --name=benchtest --size=800m --filename=/volume/test --direct=1 --rw=randrw --ioengine=libaio --bs=4k --iodepth=16 --numjobs=8 --time_based --runtime=60
```