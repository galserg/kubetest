Нравится за гибкость и лаконичность

не претендую на истину

```
helmfile -e test -f cilium.yaml apply

kubectl create ns metallb-system
kubectl label ns metallb-system pod-security.kubernetes.io/enforce=privileged pod-security.kubernetes.io/audit=privileged pod-security.kubernetes.io/warn=privileged
helmfile -e test -f metallb.yaml apply
kubectl -f hack/metallb.yaml apply

kubectl create ns mayastor
kubectl label ns mayastor pod-security.kubernetes.io/enforce=privileged pod-security.kubernetes.io/audit=privileged pod-security.kubernetes.io/warn=privileged
helmfile -e test -f mayastor.yaml apply

kubectl create ns monitoring
kubectl label ns monitoring pod-security.kubernetes.io/enforce=privileged pod-security.kubernetes.io/audit=privileged pod-security.kubernetes.io/warn=privileged
helm install po prometheus-community/kube-prometheus-stack -n monitoring
helmfile -e test -f monitoring.yaml apply

helmfile -e test -f metrics-server.yaml apply

helmfile -e test -f piraeus.yaml apply

kubectl create ns piraeus-datastore
kubectl label ns piraeus-datastore pod-security.kubernetes.io/enforce=privileged pod-security.kubernetes.io/audit=privileged pod-security.kubernetes.io/warn=privileged
helmfile -e test -f piraeus.yaml apply

```