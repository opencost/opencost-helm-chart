# OpenCost Helm Chart CI Test Values

This directory contains test values files for CI/CD validation of the OpenCost Helm chart. Each file tests a specific configuration scenario to ensure the chart works correctly across different use cases.

## Test Scenarios

### 1. `mcp-enabled-values.yaml`
**Purpose:** Tests MCP (Model Context Protocol) server configuration  
**Use Case:** AI agent integration for cost data access  
**Key Features:**
- MCP server enabled on port 8081
- Ingress configuration for MCP endpoint

### 2. `external-prometheus-values.yaml`
**Purpose:** Tests external Prometheus configuration  
**Use Case:** Using Grafana Cloud or other external Prometheus  
**Key Features:**
- External Prometheus URL
- Basic authentication
- Internal Prometheus disabled

### 3. `aws-amp-values.yaml`
**Purpose:** Tests AWS AMP (Amazon Managed Prometheus) integration  
**Use Case:** AWS EKS clusters with AMP  
**Key Features:**
- AMP workspace configuration
- SigV4 proxy for AWS authentication
- IAM role annotations

### 4. `cloud-costs-enabled-values.yaml`
**Purpose:** Tests cloud cost integration  
**Use Case:** Multi-cloud cost visibility  
**Key Features:**
- Cloud cost ingestion enabled
- Cloud integration secret reference
- AWS credentials configuration

### 5. `custom-pricing-values.yaml`
**Purpose:** Tests custom pricing configuration  
**Use Case:** On-premises or custom pricing models  
**Key Features:**
- Custom cost model
- ConfigMap creation
- Custom provider settings

### 6. `ingress-enabled-values.yaml`
**Purpose:** Tests ingress configuration for UI and API  
**Use Case:** External access to OpenCost  
**Key Features:**
- UI ingress with TLS
- API ingress with TLS
- Cert-manager integration

### 7. `persistence-enabled-values.yaml`
**Purpose:** Tests persistent storage configuration  
**Use Case:** Data persistence and collector data source  
**Key Features:**
- PVC configuration
- Collector data source enabled
- Custom storage class

### 8. `plugins-enabled-values.yaml`
**Purpose:** Tests plugin installation and configuration  
**Use Case:** Third-party integrations (e.g., Datadog)  
**Key Features:**
- Plugin installation enabled
- Datadog plugin configuration
- Security context for plugin installer

### 9. `high-availability-values.yaml`
**Purpose:** Tests HA configuration  
**Use Case:** Production deployments requiring high availability  
**Key Features:**
- Multiple replicas (3)
- Pod Disruption Budget
- Topology spread constraints
- Anti-affinity rules

### 10. `servicemonitor-enabled-values.yaml`
**Purpose:** Tests Prometheus Operator ServiceMonitor  
**Use Case:** Prometheus Operator-based monitoring  
**Key Features:**
- ServiceMonitor creation
- Metric relabeling
- KSM metrics configuration
- Custom metrics config

## Running Tests Locally

### Quick Start with Makefile (Recommended)

The repository includes a Makefile for easy local testing:

```bash
# Show all available targets
make help

# Quick test (lint default values only - fastest for iteration)
make quick

# Lint all CI scenarios
make lint-ci

# Lint default + all CI scenarios
make lint-all

# Template all scenarios
make template

# Run all tests (lint + template + schema validation)
make test-all

# List all CI test files
make list-ci
```

### Manual Testing

The chart uses [chart-testing (ct)](https://github.com/helm/chart-testing) which automatically discovers and tests all files in the `ci/` directory.

#### Test Individual Scenarios

```bash
# Lint a specific scenario
helm lint . -f ci/mcp-enabled-values.yaml

# Template a specific scenario
helm template opencost . -f ci/mcp-enabled-values.yaml

# Template and validate with kubectl
helm template opencost . -f ci/mcp-enabled-values.yaml | kubectl apply --dry-run=client -f -
```

#### Test All Scenarios with chart-testing

```bash
# Install chart-testing
brew install chart-testing  # macOS
# or follow: https://github.com/helm/chart-testing#installation

# Run chart-testing lint (tests all ci/*.yaml files automatically)
ct lint --config .github/configs/ct.yaml --lint-conf .github/configs/lintconf.yaml --charts charts/opencost

# Run chart-testing install (requires kind cluster)
kind create cluster
ct install --config .github/configs/ct.yaml --charts charts/opencost
```

#### Schema Validation

Schema validation is enabled in the CI workflow via `validate-chart-schema: true` in `.github/configs/ct.yaml`.

```bash
# Validate schema manually
make validate-schema

# Or with python directly
python3 -m json.tool charts/opencost/values.schema.json > /dev/null
```

## CI/CD Integration

This chart uses the standard [chart-testing](https://github.com/helm/chart-testing) workflow which automatically:
- Discovers all `ci/*.yaml` files
- Lints each configuration
- Validates against the schema
- Installs and tests in a kind cluster

The CI workflow is defined in `.github/workflows/helm-test.yml` and uses:
- `.github/configs/ct.yaml` - chart-testing configuration
- `.github/configs/lintconf.yaml` - yamllint configuration

### How chart-testing Works

When you add a new file to `ci/`, chart-testing will automatically:
1. **Lint** the chart with those values
2. **Validate** against `values.schema.json` (if `validate-chart-schema: true`)
3. **Install** the chart in a test cluster
4. **Test** the deployment

No additional workflow changes needed!

## Adding New Test Scenarios

When adding new features to the chart:

1. Create a new `feature-name-values.yaml` file in this directory
2. Include only the values relevant to testing that feature
3. Add documentation to this README
4. Ensure the file passes `helm lint --strict`
5. Test with `helm template` to verify rendered manifests

## Best Practices

- **Keep files focused:** Each file should test a specific scenario
- **Use realistic values:** Even test values should be plausible
- **Document purpose:** Clear comments in each file
- **Test combinations:** Consider creating files that test feature interactions
- **Validate schema:** Ensure all values conform to `values.schema.json`

## Troubleshooting

### Lint Failures

If `helm lint` fails:
1. Check the error message for the specific issue
2. Verify values against `values.schema.json`
3. Ensure all required fields are present
4. Check for YAML syntax errors

### Template Failures

If `helm template` fails:
1. Check template logic in `templates/` directory
2. Verify conditional statements handle the test values
3. Ensure all referenced values exist
4. Check for missing required values

## Related Files

- [`values.yaml`](../values.yaml) - Default chart values
- [`values.schema.json`](../values.schema.json) - JSON Schema for validation
- [`values-openshift.yaml`](../values-openshift.yaml) - OpenShift-specific values