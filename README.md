# opencost-helm-chart
OpenCost Helm chart

Based on https://raw.githubusercontent.com/opencost/opencost/develop/kubernetes/opencost.yaml

# Prerequisites

Currently expects Prometheus to be installed separately. You can do this with the following:
```
helm install my-prometheus --repo https://prometheus-community.github.io/helm-charts prometheus \
  --namespace prometheus --create-namespace \
  --set pushgateway.enabled=false \
  --set alertmanager.enabled=false \
  -f https://raw.githubusercontent.com/opencost/opencost/develop/kubernetes/prometheus/extraScrapeConfigs.yaml
```

# Usage

You may install OpenCost to the `opencost` namespace with:
```
helm install -f values.yaml opencost .
```

You may override any values as necessary.

# Links

* https://github.com/opencost/opencost/tree/develop/kubernetes
* https://www.opencost.io/docs/
