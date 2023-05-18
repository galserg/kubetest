```
cilium status --wait
kubectl create ns cilium-test
kubectl label  ns cilium-test pod-security.kubernetes.io/enforce=privileged
cilium connectivity test
```
