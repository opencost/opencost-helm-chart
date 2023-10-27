# opencost

OpenCost and OpenCost UI

![Version: 1.22.1](https://img.shields.io/badge/Version-1.22.1-informational?style=flat-square)
![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)
![AppVersion: 1.106.4](https://img.shields.io/badge/AppVersion-1.106.4-informational?style=flat-square)

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| mattray |  | <https://mattray.dev> |
| toscott |  |  |

## Installing the Chart

To install the chart with the release name `opencost`:

```console
$ helm install opencost opencost/opencost
```

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| annotations | object | `{}` | Annotations to add to the all the resources |
| extraVolumes | list | `[]` | A list of volumes to be added to the pod |
| fullnameOverride | string | `""` | Overwrite all resources name created by the chart |
| imagePullSecrets | list | `[]` | List of secret names to use for pulling the images |
| nameOverride | string | `""` | Overwrite the default name of the chart |
| opencost.affinity | object | `{}` | Affinity settings for pod assignment |
| opencost.customPricing.configPath | string | `"/tmp/custom-config"` | Path for the pricing configuration. |
| opencost.customPricing.configmapName | string | `"custom-pricing-model"` |  |
| opencost.customPricing.costModel | object | `{"CPU":1.25,"GPU":0.95,"RAM":0.5,"description":"Modified prices based on your internal pricing","internetNetworkEgress":0.12,"regionNetworkEgress":0.01,"spotCPU":0.006655,"spotRAM":0.000892,"storage":0.25,"zoneNetworkEgress":0.01}` | More information about these values here: https://www.opencost.io/docs/configuration/on-prem#custom-pricing-using-the-opencost-helm-chart |
| opencost.customPricing.createConfigmap | bool | `true` | Configures the pricing model provided in the values file. |
| opencost.customPricing.enabled | bool | `false` | Enables custom pricing for on-premise setup. |
| opencost.exporter.aws.access_key_id | string | `""` | AWS secret key id |
| opencost.exporter.aws.secret_access_key | string | `""` | AWS secret access key |
| opencost.exporter.cloudProviderApiKey | string | `""` | The GCP Pricing API requires a key. This is supplied just for evaluation. |
| opencost.exporter.csv_path | string | `""` |  |
| opencost.exporter.defaultClusterId | string | `"default-cluster"` | Default cluster ID to use if cluster_id is not set in Prometheus metrics. |
| opencost.exporter.env | list | `[]` | List of additional environment variables to set in the container |
| opencost.exporter.extraEnv | object | `{}` | Any extra environment variables you would like to pass on to the pod |
| opencost.exporter.extraVolumeMounts | list | `[]` | A list of volume mounts to be added to the pod |
| opencost.exporter.image.pullPolicy | string | `"IfNotPresent"` | Exporter container image pull policy |
| opencost.exporter.image.registry | string | `"quay.io"` | Exporter container image registry |
| opencost.exporter.image.repository | string | `"kubecost1/kubecost-cost-model"` | Exporter container image name |
| opencost.exporter.image.tag | string | `""` (use appVersion in Chart.yaml) | Exporter container image tag |
| opencost.exporter.livenessProbe.enabled | bool | `true` | Whether probe is enabled |
| opencost.exporter.livenessProbe.failureThreshold | int | `3` | Number of failures for probe to be considered failed |
| opencost.exporter.livenessProbe.initialDelaySeconds | int | `120` | Number of seconds before probe is initiated |
| opencost.exporter.livenessProbe.periodSeconds | int | `10` | Probe frequency in seconds |
| opencost.exporter.persistence.accessMode | string | `""` | Access mode for persistent volume |
| opencost.exporter.persistence.annotations | object | `{}` | Annotations for persistent volume |
| opencost.exporter.persistence.enabled | bool | `false` |  |
| opencost.exporter.persistence.size | string | `""` | Size for persistent volume |
| opencost.exporter.persistence.storageClass | string | `""` | Storage class for persistent volume |
| opencost.exporter.readinessProbe.enabled | bool | `true` | Whether probe is enabled |
| opencost.exporter.readinessProbe.failureThreshold | int | `3` | Number of failures for probe to be considered failed |
| opencost.exporter.readinessProbe.initialDelaySeconds | int | `120` | Number of seconds before probe is initiated |
| opencost.exporter.readinessProbe.periodSeconds | int | `10` | Probe frequency in seconds |
| opencost.exporter.replicas | int | `1` | Number of OpenCost replicas to run |
| opencost.exporter.resources.limits | object | `{"cpu":"999m","memory":"1Gi"}` | CPU/Memory resource limits |
| opencost.exporter.resources.requests | object | `{"cpu":"10m","memory":"55Mi"}` | CPU/Memory resource requests |
| opencost.exporter.securityContext | object | `{}` | The security options the container should be run with |
| opencost.metrics.serviceMonitor.additionalLabels | object | `{}` | Additional labels to add to the ServiceMonitor |
| opencost.metrics.serviceMonitor.enabled | bool | `false` | Create ServiceMonitor resource for scraping metrics using PrometheusOperator |
| opencost.metrics.serviceMonitor.honorLabels | bool | `true` | HonorLabels chooses the metric's labels on collisions with target labels |
| opencost.metrics.serviceMonitor.metricRelabelings | list | `[]` | MetricRelabelConfigs to apply to samples before ingestion |
| opencost.metrics.serviceMonitor.namespace | string | `""` | Specify if the ServiceMonitor will be deployed into a different namespace (blank deploys into same namespace as chart) |
| opencost.metrics.serviceMonitor.relabelings | list | `[]` | RelabelConfigs to apply to samples before scraping. Prometheus Operator automatically adds relabelings for a few standard Kubernetes fields |
| opencost.metrics.serviceMonitor.scheme | string | `"http"` | HTTP scheme used for scraping. Defaults to `http` |
| opencost.metrics.serviceMonitor.scrapeInterval | string | `"30s"` | Interval at which metrics should be scraped |
| opencost.metrics.serviceMonitor.scrapeTimeout | string | `"10s"` | Timeout after which the scrape is ended |
| opencost.metrics.serviceMonitor.tlsConfig | object | `{}` | TLS configuration for scraping metrics |
| opencost.nodeSelector | object | `{}` | Node labels for pod assignment |
| opencost.prometheus.bearer_token | string | `""` | Prometheus Bearer token |
| opencost.prometheus.bearer_token_key | string | `"DB_BEARER_TOKEN"` |  |
| opencost.prometheus.external.enabled | bool | `false` | Use external Prometheus (eg. Grafana Cloud) |
| opencost.prometheus.external.url | string | `"https://prometheus.example.com/prometheus"` | External Prometheus url |
| opencost.prometheus.internal.enabled | bool | `true` | Use in-cluster Prometheus |
| opencost.prometheus.internal.namespaceName | string | `"opencost"` | Namespace of in-cluster Prometheus |
| opencost.prometheus.internal.port | int | `9090` | Service port of in-cluster Prometheus |
| opencost.prometheus.internal.serviceName | string | `"my-prometheus"` | Service name of in-cluster Prometheus |
| opencost.prometheus.password | string | `""` | Prometheus Basic auth password |
| opencost.prometheus.password_key | string | `"DB_BASIC_AUTH_PW"` | Key in the secret that references the password |
| opencost.prometheus.secret_name | string | `nil` | Secret name that contains credentials for Prometheus |
| opencost.prometheus.thanos.enabled | bool | `false` |  |
| opencost.prometheus.thanos.external.enabled | bool | `false` |  |
| opencost.prometheus.thanos.external.url | string | `"https://thanos-query.example.com/thanos"` |  |
| opencost.prometheus.thanos.internal.enabled | bool | `true` |  |
| opencost.prometheus.thanos.internal.namespaceName | string | `"opencost"` |  |
| opencost.prometheus.thanos.internal.port | int | `10901` |  |
| opencost.prometheus.thanos.internal.serviceName | string | `"my-thanos-query"` |  |
| opencost.prometheus.thanos.maxSourceResolution | string | `""` |  |
| opencost.prometheus.thanos.queryOffset | string | `""` |  |
| opencost.prometheus.username | string | `""` | Prometheus Basic auth username |
| opencost.prometheus.username_key | string | `"DB_BASIC_AUTH_USERNAME"` | Key in the secret that references the username |
| opencost.tolerations | list | `[]` | Toleration labels for pod assignment |
| opencost.topologySpreadConstraints | list | `[]` | Assign custom TopologySpreadConstraints rules |
| opencost.ui.enabled | bool | `true` | Enable OpenCost UI |
| opencost.ui.extraVolumeMounts | list | `[]` | A list of volume mounts to be added to the pod |
| opencost.ui.image.pullPolicy | string | `"IfNotPresent"` | UI container image pull policy |
| opencost.ui.image.registry | string | `"quay.io"` | UI container image registry |
| opencost.ui.image.repository | string | `"kubecost1/opencost-ui"` | UI container image name |
| opencost.ui.image.tag | string | `""` (use appVersion in Chart.yaml) | UI container image tag |
| opencost.ui.ingress.annotations | object | `{}` | Annotations for Ingress resource |
| opencost.ui.ingress.enabled | bool | `false` | Ingress for OpenCost UI |
| opencost.ui.ingress.hosts | list | See [values.yaml](values.yaml) | A list of host rules used to configure the Ingress |
| opencost.ui.ingress.ingressClassName | string | `""` | Ingress controller which implements the resource |
| opencost.ui.ingress.tls | list | `[]` | Ingress TLS configuration |
| opencost.ui.livenessProbe.enabled | bool | `true` | Whether probe is enabled |
| opencost.ui.livenessProbe.failureThreshold | int | `3` | Number of failures for probe to be considered failed |
| opencost.ui.livenessProbe.initialDelaySeconds | int | `30` | Number of seconds before probe is initiated |
| opencost.ui.livenessProbe.periodSeconds | int | `10` | Probe frequency in seconds |
| opencost.ui.readinessProbe.enabled | bool | `true` | Whether probe is enabled |
| opencost.ui.readinessProbe.failureThreshold | int | `3` | Number of failures for probe to be considered failed |
| opencost.ui.readinessProbe.initialDelaySeconds | int | `30` | Number of seconds before probe is initiated |
| opencost.ui.readinessProbe.periodSeconds | int | `10` | Probe frequency in seconds |
| opencost.ui.resources.limits | object | `{"cpu":"999m","memory":"1Gi"}` | CPU/Memory resource limits |
| opencost.ui.resources.requests | object | `{"cpu":"10m","memory":"55Mi"}` | CPU/Memory resource requests |
| opencost.ui.securityContext | object | `{}` | The security options the container should be run with |
| podAnnotations | object | `{}` | Annotations to add to the OpenCost Pod |
| podLabels | object | `{}` | Labels to add to the OpenCost Pod |
| podSecurityContext | object | `{}` | Holds pod-level security attributes and common container settings |
| priorityClassName | string | `nil` | Pod priority |
| rbac.enabled | bool | `true` |  |
| secretAnnotations | object | `{}` | Annotations to add to the Secret |
| service.annotations | object | `{}` | Annotations to add to the service |
| service.enabled | bool | `true` |  |
| service.labels | object | `{}` | Labels to add to the service account |
| service.type | string | `"ClusterIP"` | Kubernetes Service type |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.automountServiceAccountToken | bool | `true` | Whether pods running as this service account should have an API token automatically mounted |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `""` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)
