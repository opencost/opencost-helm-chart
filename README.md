# OpenCost Helm Chart
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0) ![Chart Publish](https://github.com/opencost/opencost-helm-chart/workflows/chart-publish/badge.svg?branch=main) [![Releases downloads](https://img.shields.io/github/downloads/opencost/opencost-helm-chart/total.svg)](https://github.com/opencost/opencost-helm-charts/releases)

## Maintainers

| Name |
| ---- |
| mattray |
| toscott |
| brito-rafa |

## Usage

[Helm](https://helm.sh/) must be installed to use the charts. Please refer to Helm's [documentation](https://helm.sh/docs/) to get started.

Once Helm is set up properly, add the repo as follows:

```console
helm repo add opencost https://opencost.github.io/opencost-helm-chart
```

See the [Chart Documentation](https://github.com/opencost/opencost-helm-chart/blob/main/charts/opencost/README.md) for chart install instructions.

## Testing

[Testing](https://github.com/helm-unittest/helm-unittest) your chart (optional)

Presumes you've got Helm unittest installed: (i.e. `helm plugin install unittest`) and that your in the root directory of your cloned repo:

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
