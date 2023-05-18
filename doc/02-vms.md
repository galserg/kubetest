единственная машина которую сетапал руками (потом можно поменять) служебная для провижинга талоса
нам понадобиться tftp + pxe (ipxe)
выбрал matchbox
но все что нужно сделать руками - поставить докер
тривиальный сетап убуниу, статический ip 192.168.3.100

```
ssh user@192.168.3.100
```

```
sudo apt update
sudo apt install nmap wget mc fio git
sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update
sudo apt-get install docker-ce docker-ce-cli containerd.io
sudo usermod -aG docker $USER
```