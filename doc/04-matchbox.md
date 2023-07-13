идем на виртуалку настраивать matchbox

```
ssh user@192.168.3.100
git clone https://github.com/galserg/kubetest.git
cd kubetest
cp -r docker /data
mkdir -p /data/volumes/matchbox/var/lib/matchbox/assets
mkdir -p /data/volumes/matchbox/etc/matchbox
cp config/* /data/volumes/matchbox/var/lib/matchbox/assets
cd /data/volumes/matchbox/var/lib/matchbox/assets
wget https://github.com/siderolabs/talos/releases/download/v1.3.6/vmlinuz-amd64 -O vmlinuz
wget https://github.com/siderolabs/talos/releases/download/v1.3.6/initramfs-amd64.xz -O initramfs.xz
cd ..
git clone https://github.com/poseidon/matchbox.git
cd matchbox
cd scripts/tls
export SAN=DNS.1:matchbox.home,IP.1:192.168.3.100
./cert-gen
cp ca.crt server.crt server.key /data/volumes/matchbox/etc/matchbox

cd /data/docker
docker compose up
sudo systemctl stop systemd-resolved
sudo systemctl disable systemd-resolved
docker compose up -d
```
копируем себе сгенерированные сертификаты client.crt client.key ca.crt
```
terraform init -upgrade

```
дальнейшее управление matchbox - терраформом

```
wget https://github.com/siderolabs/talos/releases/download/v1.4.5/vmlinuz-amd64 -O vmlinuz
wget https://github.com/siderolabs/talos/releases/download/v1.4.5/initramfs-amd64.xz -O initramfs.xz
git clone https://github.com/poseidon/matchbox.git
cd matchbox
cd scripts/tls
export SAN=DNS.1:matchbox1.home,IP.1:192.168.3.150
./cert-gen
cp ca.crt server.crt server.key /data/volumes/matchbox/etc/matchbox

```