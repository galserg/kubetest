```
kubectl mayastor get nodes
 ID   GRPC ENDPOINT        STATUS  CORDONED 
 wr1  192.168.3.111:10124  Online  false 
 wr2  192.168.3.112:10124  Online  false 
 wr3  192.168.3.113:10124  Online  false 
kubectl -f hack/mayastor/pool.yaml apply

kubectl mayastor get pools
 ID             TOTAL CAPACITY  USED CAPACITY  DISKS                                                     NODE  STATUS  MANAGED 
 pool-worker-3  51485081600     0              aio:///dev/vdb?uuid=3c3fd216-88b6-4360-ba2e-2ddf94f1df38  wr3   Online  true 
 pool-worker-1  51485081600     0              aio:///dev/vdb?uuid=648a1f70-c4bc-4a3a-9fbc-2eac016e8860  wr1   Online  true 
 pool-worker-2  51485081600     0              aio:///dev/vdb?uuid=a92d885d-3c07-4313-800e-2fb6d62c4aa2  wr2   Online  true  

kubectl -f hack/mayastor/class.yaml apply
kubectl -f hack/mayastor/pvc.yaml apply

kubectl mayastor get volumes
 ID                                    REPLICAS  TARGET-NODE  ACCESSIBILITY  STATUS  SIZE         THIN-PROVISIONED 
 6b8d25c5-ab7b-4f9b-844d-817c4566c541  3         wr3          nvmf           Online  16000000000  false ```
```
## Важно!
в чарте к-во реплик etcd должно равняться к-ву нод с маястором, иначе будет горе

Для тестирования скорости
```
kubectl label ns default pod-security.kubernetes.io/enforce=privileged pod-security.kubernetes.io/audit=privileged pod-security.kubernetes.io/warn=privileged
kubectl apply -f https://raw.githubusercontent.com/openebs/Mayastor/v1.0.2/deploy/fio.yaml
kubectl exec -it fio -- fio --name=benchtest --size=800m --filename=/volume/test --direct=1 --rw=randrw --ioengine=libaio --bs=4k --iodepth=16 --numjobs=8 --time_based --runtime=60
```