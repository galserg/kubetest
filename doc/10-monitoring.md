```
Failed to scrape node" err="Get \"https://192.168.3.112:10250/metrics/resource\": 
x509: cannot validate certificate for 192.168.3.112 because it doesn't contain any IP SANs" node="wr2"

https://www.talos.dev/v1.4/kubernetes-guides/configuration/deploy-metrics-server/

По умолчанию сертификаты, используемые кублетами, не распознаются metrics-server. 
Эту проблему можно решить либо настроив metrics-server так, чтобы он не выполнял проверку сертификатов TLS, 
либо изменив конфигурацию kubelet,

    values:
      - args:
          - --kubelet-insecure-tls

вопрос решился
потом можно рассотреть по хавту ротацию кубелет сертификатов
```

TODO. С метрик сервером чтото не так все равно (а может с прометеусом?). LENS метрики кластера не показывает
демонсет нод экспортера тоже не жочет запускаться с этими под секьюрити!