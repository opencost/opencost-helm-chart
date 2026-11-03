# OpenCost Helm Chart
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
![Chart Publish](https://github.com/opencost/opencost-helm-chart/workflows/chart-publish/badge.svg)
[![Releases downloads](https://img.shields.io/github/downloads/opencost/opencost-helm-chart/total.svg)](https://github.com/opencost/opencost-helm-charts/releases)
[![Artifact HUB](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/opencost)](https://artifacthub.io/packages/search?org=opencost)

## Maintainers

| Name |
| ---- |
| @jessegoodier |
| @mittal-ishaan |
| @toscott |
| @brito-rafa |

## Usage

[Helm](https://helm.sh/) must be installed to use the charts. Please refer to Helm's [documentation](https://helm.sh/docs/) to get started.

Once Helm is set up properly, add the repo as follows:

```console
helm repo add opencost https://opencost.github.io/opencost-helm-chart
```

See the [Chart Documentation](https://github.com/opencost/opencost-helm-chart/blob/main/charts/opencost/README.md) for chart install instructions.

### Use an existing in-cluster Prometheus

If Prometheus is already installed in the cluster, OpenCost can query that Service instead of deploying or pointing at a separate external endpoint. Configure the internal Prometheus connection with the Service name and namespace used by your monitoring stack:

```yaml
opencost:
  prometheus:
    external:
      enabled: false
    internal:
      enabled: true
      serviceName: monitoring-kube-prometheus-prometheus
      namespaceName: monitoring
      port: 9090
      scheme: http
```

The Service name is release-dependent; confirm it with `kubectl get svc -n <prometheus-namespace>` before installing OpenCost. Keep only the Prometheus mode you intend to use enabled. For authenticated OpenShift/Thanos-style endpoints, use the chart's external Prometheus and RBAC proxy options documented in `values.yaml`.


## Testing

[Testing](https://github.com/helm-unittest/helm-unittest) your chart (optional)

Presumes you've got Helm unittest installed: (i.e. `helm plugin install https://github.com/helm-unittest/helm-unittest`) and that your in the root directory of your cloned repo:

```console
helm unittest charts/opencost
```
Should produce a result like this:

```
### Chart [ opencost ] charts/opencost

 PASS  test deployment	charts/opencost/tests/deployment_test.yaml
 PASS  test deployment snapshot	charts/opencost/tests/opencost_test.yaml

Charts:      1 passed, 1 total
Test Suites: 2 passed, 2 total
Tests:       2 passed, 2 total
Snapshot:    1 passed, 1 total
Time:        31.011089ms
```

***

## OpenCost Links
* [OpenCost](https://github.com/opencost/opencost)
* [Documentation](https://www.opencost.io/docs/)
