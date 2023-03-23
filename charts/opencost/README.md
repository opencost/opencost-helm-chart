# opencost

OpenCost and OpenCost UI

![Version: 1.7.0](https://img.shields.io/badge/Version-1.7.0-informational?style=flat-square)
![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)
![AppVersion: 1.101.2](https://img.shields.io/badge/AppVersion-1.101.2-informational?style=flat-square)

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| mattray |  | <https://mattray.dev> |

## Installing the Chart

To install the chart with the release name `opencost`:

```console
$ helm install opencost opencost/opencost
```

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| annotations | object | `{}` | Annotations to add to the Deployment |
| extraVolumes | list | `[]` | A list of volumes to be added to the pod |
| networkpolicies.custom.enabled | bool | `false` | Specifies whether custom networkpolicies should be created |
| networkpolicies.custom.rules | string | `nil` | Custom networkpolicies for more complex K8s environments. Passes metadata and spec directly to networkpolicy template. |
| networkpolicies.enabled | bool | `false` | Specifies whether networkpolicies should be created |
| networkpolicies.exporter.enabled | bool | `true` | Specifies whether ingress networkpolicy for exporter metrics should be created |
| networkpolicies.exporter.scraperLabels | string | `nil` | Pod labels of metrics scraper (e.g. prometheus) to allow access to exporter |
| networkpolicies.exporter.scraperNamespace | string | `"opencost"` | Namespace of prometheus to allow access to exporter |
| networkpolicies.prometheus.enabled | bool | `true` | Specifies whether egress networkpolicies for in-cluster Prometheus should be created |
| networkpolicies.prometheus.labels | string | `nil` | - Pod labels of in-cluster Prometheus to allow access to in-cluster Prometheus |
| opencost.affinity | object | `{}` | Affinity settings for pod assignment |
| opencost.exporter.cloudProviderApiKey | string | `""` | The GCP Pricing API requires a key. This is supplied just for evaluation. |
| opencost.exporter.defaultClusterId | string | `"default-cluster"` | Default cluster ID to use if cluster_id is not set in Prometheus metrics. |
| opencost.exporter.extraEnv | object | `{}` | Any extra environment variables you would like to pass on to the pod |
| opencost.exporter.extraVolumeMounts | list | `[]` | A list of volume mounts to be added to the pod |
| opencost.exporter.image.registry | string | `"quay.io"` | Exporter container image registry |
| opencost.exporter.image.repository | string | `"kubecost1/kubecost-cost-model"` | Exporter container image name |
| opencost.exporter.image.tag | string | `""` (use appVersion in Chart.yaml) | Exporter container image tag |
| opencost.exporter.replicas | int | `1` | Number of OpenCost replicas to run |
| opencost.exporter.resources.limits | object | `{"cpu":"999m","memory":"1Gi"}` | CPU/Memory resource limits |
| opencost.exporter.resources.requests | object | `{"cpu":"10m","memory":"55Mi"}` | CPU/Memory resource requests |
| opencost.exporter.securityContext | object | `{}` | The security options the container should be run with |
| opencost.metrics.serviceMonitor.additionalLabels | object | `{}` | Additional labels to add to the ServiceMonitor |
| opencost.metrics.serviceMonitor.enabled | bool | `false` | Create ServiceMonitor resource for scraping metrics using PrometheusOperator |
| opencost.metrics.serviceMonitor.honorLabels | bool | `false` | HonorLabels chooses the metric's labels on collisions with target labels |
| opencost.metrics.serviceMonitor.metricRelabelings | list | `[]` | MetricRelabelConfigs to apply to samples before ingestion |
| opencost.metrics.serviceMonitor.namespace | string | `""` | Specify if the ServiceMonitor will be deployed into a different namespace (blank deploys into same namespace as chart) |
| opencost.metrics.serviceMonitor.relabelings | list | `[]` | RelabelConfigs to apply to samples before scraping. Prometheus Operator automatically adds relabelings for a few standard Kubernetes fields |
| opencost.metrics.serviceMonitor.scrapeInterval | string | `"30s"` | Interval at which metrics should be scraped |
| opencost.nodeSelector | object | `{}` | Node labels for pod assignment |
| opencost.prometheus.bearer_token | string | `""` | Prometheus Bearer token |
| opencost.prometheus.external.enabled | bool | `false` | Use external Prometheus (eg. Grafana Cloud) |
| opencost.prometheus.external.url | string | `"https://mimir-dev-push.infra.alto.com/prometheus"` | External Prometheus url |
| opencost.prometheus.internal.enabled | bool | `true` | Use in-cluster Prometheus |
| opencost.prometheus.internal.namespaceName | string | `"opencost"` | Namespace of in-cluster Prometheus |
| opencost.prometheus.internal.podPort | int | `9090` | Pod port of in-cluster Prometheus |
| opencost.prometheus.internal.serviceName | string | `"my-prometheus"` | Service name of in-cluster Prometheus |
| opencost.prometheus.internal.servicePort | int | `9090` | Service port of in-cluster Prometheus |
| opencost.prometheus.password | string | `""` | Prometheus Basic auth password |
| opencost.prometheus.username | string | `""` | Prometheus Basic auth username |
| opencost.tolerations | list | `[]` | Toleration labels for pod assignment |
| opencost.topologySpreadConstraints | list | `[]` | Assign custom TopologySpreadConstraints rules |
| opencost.ui.enabled | bool | `true` | Enable OpenCost UI |
| opencost.ui.extraVolumeMounts | list | `[]` | A list of volume mounts to be added to the pod |
| opencost.ui.image.registry | string | `"quay.io"` | UI container image registry |
| opencost.ui.image.repository | string | `"kubecost1/opencost-ui"` | UI container image name |
| opencost.ui.image.tag | string | `""` (use appVersion in Chart.yaml) | UI container image tag |
| opencost.ui.resources.limits | object | `{"cpu":"999m","memory":"1Gi"}` | CPU/Memory resource limits |
| opencost.ui.resources.requests | object | `{"cpu":"10m","memory":"55Mi"}` | CPU/Memory resource requests |
| opencost.ui.securityContext | object | `{}` | The security options the container should be run with |
| podAnnotations | object | `{}` | Annotations to add to the OpenCost Pod |
| podSecurityContext | object | `{}` | Holds pod-level security attributes and common container settings |
| service.annotations | object | `{}` | Annotations to add to the service |
| service.labels | object | `{}` | Labels to add to the service account |
| service.type | string | `"ClusterIP"` | Kubernetes Service type |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.automountServiceAccountToken | bool | `true` | Whether pods running as this service account should have an API token automatically mounted |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)
## Docs Generated by [helm-docs](https://github.com/norwoodj/helm-docs)
`helm-docs -t .README.md.gotmpl`
