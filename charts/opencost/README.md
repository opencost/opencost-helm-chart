# Opencost

Helm chart for the Opencost project, which is created to monitor and manage Kubernetes spend. Please visit [opencost.io](https://opencost.io) for more info.

## Prerequisites

- Kubernetes 1.16+
- Helm 3.7+

## Get Repository Info

```console
helm repo add opencost https://opencost.github.io/opencost-helm-chart
helm repo update
```

_See [helm repository](https://helm.sh/docs/helm/helm_repo/) for command documentation._

## Install Chart

Start from Version 16.0, Opencost chart required Helm 3.7+ in order to install successfully. Please check your Helm chart version before installation.

```console
helm install [RELEASE_NAME] opencost/opencost
```

_See [configuration](#configuration) below._

_See [helm install](https://helm.sh/docs/helm/helm_install/) for command documentation._

## Uninstall Chart

```console
helm uninstall [RELEASE_NAME]
```

This removes all the Kubernetes components associated with the chart and deletes the release.

_See [helm uninstall](https://helm.sh/docs/helm/helm_uninstall/) for command documentation._

## Upgrading Chart

```console
helm upgrade [RELEASE_NAME] [CHART] --install
```

_See [helm upgrade](https://helm.sh/docs/helm/helm_upgrade/) for command documentation._

## Configuration
The following table lists commonly used configuration parameters for the Opencost Helm chart and their default values.

| Parameter                                                                          | Description                                                                                                                                                  | Default             |
|------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------|
| `global.prometheus.enabled`                                                        | If false, use an existing Prometheus install.                                                                                                                | `true`              |
| `prometheus.kube-state-metrics.disabled`                                           | If false, deploy [kube-state-metrics](https://github.com/kubernetes/kube-state-metrics) for Kubernetes metrics                                               | `false`             |
| `prometheus.kube-state-metrics.resources`                                          | Set kube-state-metrics resource requests and limits.                                                                                                         | `{}`                |
| `prometheus.server.persistentVolume.enabled`                                       | If true, Prometheus server will create a Persistent Volume Claim.                                                                                            | `true`              |
| `prometheus.server.persistentVolume.size`                                          | Prometheus server data Persistent Volume size. Default set to retain ~6000 samples per second for 15 days.                                                   | `32Gi`              |
| `prometheus.server.persistentVolume.storageClass`                                  | Define storage class for Prometheus persistent volume                                                                                                        | `-`                 |
| `prometheus.server.retention`                                                      | Determines when to remove old data.                                                                                                                          | `15d`               |
| `prometheus.server.resources`                                                      | Prometheus server resource requests and limits.                                                                                                              | `{}`                |
| `prometheus.nodeExporter.resources`                                                | Node exporter resource requests and limits.                                                                                                                  | `{}`                |
| `prometheus.nodeExporter.enabled` `prometheus.serviceAccounts.nodeExporter.create` | If false, do not create NodeExporter daemonset.                                                                                                              | `true`              |
| `prometheus.alertmanager.persistentVolume.enabled`                                 | If true, Alertmanager will create a Persistent Volume Claim.                                                                                                 | `false`             |
| `prometheus.pushgateway.persistentVolume.enabled`                                  | If true, Prometheus Pushgateway will create a Persistent Volume Claim.                                                                                       | `false`             |
| `persistentVolume.enabled`                                                         | If true, Opencost will create a Persistent Volume Claim for product config data.                                                                             | `true`              |
| `persistentVolume.size`                                                            | Define PVC size for costmodel                                                                                                                                | `32.0Gi`            |
| `persistentVolume.dbSize`                                                          | Define PVC size for costmodel's flat file database                                                                                                           | `32.0Gi`            |
| `persistentVolume.storageClass`                                                    | Define storage class for costmodel's persistent volume                                                                                                       | `-`                 |
| `ingress.enabled`                                                                  | If true, Ingress will be created                                                                                                                             | `false`             |
| `ingress.annotations`                                                              | Ingress annotations                                                                                                                                          | `{}`                |
| `ingress.paths`                                                                    | Ingress paths                                                                                                                                                | `["/"]`             |
| `ingress.hosts`                                                                    | Ingress hostnames                                                                                                                                            | `[costmodel.local]` |
| `ingress.tls`                                                                      | Ingress TLS configuration (YAML)                                                                                                                             | `[]`                |
| `networkPolicy.enabled`                                                            | If true, create a NetworkPolicy to deny egress                                                                                                               | `false`             |
| `serviceMonitor.enabled`                                                           | Set this to `true` to create ServiceMonitor for Prometheus operator                                                                                          | `false`             |
| `serviceMonitor.additionalLabels`                                                  | Additional labels that can be used so ServiceMonitor will be discovered by Prometheus                                                                        | `{}`                |
| `prometheusRule.enabled`                                                           | Set this to `true` to create PrometheusRule for Prometheus operator                                                                                          | `false`             |
| `prometheusRule.additionalLabels`                                                  | Additional labels that can be used so PrometheusRule will be discovered by Prometheus                                                                        | `{}`                |
| `grafana.resources`                                                                | Grafana resource requests and limits.                                                                                                                        | `{}`                |
| `grafana.sidecar.dashboards.enabled`                                               | Set this to `false` to disable creation of Dashboards in Grafana                                                                                             | `true`              |
| `grafana.sidecar.datasources.defaultDatasourceEnabled`                             | Set this to `false` to disable creation of Prometheus datasource in Grafana                                                                                  | `true`              |
| `serviceAccount.create`                                                            | Set this to `false` if you want to create the service account `opencost` on your own                                                                         | `true`              |
| `tolerations`                                                                      | node taints to tolerate                                                                                                                                      | `[]`                |
| `affinity`                                                                         | pod affinity                                                                                                                                                 | `{}`                |
| `extraVolumes`                                                                     | A list of volumes to be added to the pod                                                                                                                     | `[]`                |
| `extraVolumeMounts`                                                                | A list of volume mounts to be added to the pod                                                                                                               | `[]`                |

## Adjusting Log Output
The log output can be adjusted while deploying through Helm by using the `LOG_LEVEL` and/or `LOG_FORMAT` environment variables.

For example, to set the log level to `trace` the following flag can be added to the helm command:

```
    --set 'opencostModel.extraEnv[0].name=LOG_LEVEL,opencostModel.extraEnv[0].value=trace'
```
`LOG_FORMAT` options:

`JSON` - A structured logging output: `{"level":"info","time":"2006-01-02T15:04:05.999999999Z07:00","message":"Starting cost-model (git commit \"1.91.0-rc.0\")"}`

`pretty` - A nice human readable output: `2006-01-02T15:04:05.999999999Z07:00 INF Starting cost-model (git commit "1.91.0-rc.0")`