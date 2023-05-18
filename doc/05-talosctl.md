## ВАЖНО!
какой талос тавим - такой talosctl и тянем

wget https://github.com/siderolabs/talos/releases/download/v1.3.6/talosctl-linux-amd64

```
talosctl gen secrets -o secrets.yaml
talosctl gen config --with-secrets secrets.yaml test-cluster https://192.168.3.200:6443 --config-patch @all.yaml --config-patch-control-plane @cp.yaml --config-patch-worker @w.yaml

talosctl --talosconfig talosconfig config endpoint 192.168.3.200
talosctl --talosconfig talosconfig config node 192.168.3.101 192.168.3.102 192.168.3.103

talosctl get members
talosctl disks
talosctl bootstrap
talosctl kubeconfig .

talosctl --talosconfig talosconfig -n 192.168.3.101 get members
NODE            NAMESPACE   TYPE     ID    VERSION   HOSTNAME   MACHINE TYPE   OS               ADDRESSES
192.168.3.101   cluster     Member   cp1   1         cp1        controlplane   Talos (v1.3.6)   ["192.168.3.101"]
192.168.3.101   cluster     Member   cp2   1         cp2        controlplane   Talos (v1.3.6)   ["192.168.3.102"]
192.168.3.101   cluster     Member   cp3   1         cp3        controlplane   Talos (v1.3.6)   ["192.168.3.103"]
192.168.3.101   cluster     Member   wr1   1         wr1        worker         Talos (v1.3.6)   ["192.168.3.111"]
192.168.3.101   cluster     Member   wr2   1         wr2        worker         Talos (v1.3.6)   ["192.168.3.112"]
192.168.3.101   cluster     Member   wr3   1         wr3        worker         Talos (v1.3.6)   ["192.168.3.113"]
```

чтобы не указывать каждый раз конфиг (--talosconfig talosconfig) можно скопировать его в ~/.talos/config

```
talosctl -n 192.168.3.101 bootstrap
talosctl -n 192.168.3.101 kubeconfig .
export KUBECONFIG="`pwd`/kubeconfig"
kubectl get nodes
NAME   STATUS     ROLES           AGE   VERSION
cp1    NotReady   control-plane   78s   v1.26.2
cp2    NotReady   control-plane   70s   v1.26.2
cp3    NotReady   control-plane   83s   v1.26.2
wr1    NotReady   <none>          83s   v1.26.2
wr2    NotReady   <none>          76s   v1.26.2
wr3    NotReady   <none>          83s   v1.26.2
```
Бутстрап говорим ОДНОЙ ноде!!!

Вообще - лучше всегда указывать опцией с какой нодой талоса хотим говорить

свалка по изменению конфига машин для линстора, потом (млжет быть) разгребу

## после добавления экстеншена нужно сделать апгрейд на ту же версию
```
talosctl --talosconfig talosconfig  apply-config -n <node> --file <config>.yaml
talosctl machineconfig patch <machineconfig-file> (--mode=reboot)
talosctl edit machineconfig

talosctl --talosconfig talosconfig edit machineconfig -n 192.168.3.111
talosctl --talosconfig talosconfig machineconfig patch -n 192.168.3.111 w-linstor.yaml --mode=reboot
talosctl --talosconfig talosconfig -n 192.168.3.111 patch machineconfig -p @w-linstor.yaml
patched MachineConfigs.config.talos.dev/v1alpha1 at the node 192.168.3.111
Applied configuration without a reboot

/////////////////
бывает важа последовательнасть опций в кли утили!!!!!!!!!
короч все применилось
но - модуля нет
talosctl --talosconfig talosconfig -n 192.168.3.111 read /proc/modules
talosctl --talosconfig talosconfig -n 192.168.3.111 read /sys/module/drbd/parameters/usermode_helper

/////////////////
Достал --talosconfig talosconfig
скопировал ено в ~/.talos/config
дальше безнего

talosctl -n 192.168.3.111 dmesg
error loading module \x5c"drbd\x5c": module not found

talosctl machineconfig patch wr1.yaml --patch @w-linstor.yaml -o wr1-linstor.yaml
talosctl apply-config -n 192.168.3.111 --file wr1-linstor.yaml --mode reboot
Applied configuration with a reboot


talosctl apply-config -n 192.168.3.111 --file wr1.yaml --mode=reboot
///////////////
talosctl apply-config -n 192.168.3.111 --file wr1-linstor.yaml --mode reboot

после добавления экстеншена нужно сделать апгрейд на ту же версию

talosctl upgrade --nodes 192.168.3.111 \
      --image ghcr.io/siderolabs/installer:v1.3.6

talosctl -n 192.168.3.111 read /proc/modules
drbd_transport_tcp 28672 - - Live 0xffffffffc02f5000 (O)
drbd 643072 - - Live 0xffffffffc0257000 (O)
talosctl -n 192.168.3.111 read /sys/module/drbd/parameters/usermode_helper
disabled

talosctl machineconfig patch wr2.yaml --patch @w-linstor.yaml -o wr2-linstor.yaml
talosctl apply-config -n 192.168.3.112 --file wr2-linstor.yaml --mode reboot
talosctl upgrade --nodes 192.168.3.112 \
      --image ghcr.io/siderolabs/installer:v1.3.6

talosctl machineconfig patch wr3.yaml --patch @w-linstor.yaml -o wr3-linstor.yaml
talosctl apply-config -n 192.168.3.113 --file wr3-linstor.yaml --mode reboot
talosctl upgrade --nodes 192.168.3.113 \
      --image ghcr.io/siderolabs/installer:v1.3.6
///////////////
после apply-config даже с опцией ребут пришлось делать ребут руками, иначе upgrade зависал навсегда
talosctl shutdown -n 192.168.3.113
как-то не завершается шутдаун, по таймауту отпадает
```

