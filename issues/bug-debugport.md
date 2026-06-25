Title: service: debugPort targetPort references wrong value causing debug port mismatch

Description

The `Service` template for the OpenCost exporter references a non-existent value `opencost.debugPort`, which prevents the Service's debug port from mapping to the container when enabled.

Files

- charts/opencost/templates/service.yaml (references `{{ .Values.opencost.debugPort }}`)
- charts/opencost/values.yaml (defines `opencost.exporter.debugPort`)

Steps to reproduce

1. Enable the exporter debug port in `values.yaml`:

```yaml
opencost:
  exporter:
    debugPort: 40000
```
2. Install the chart.
3. Observe that the Service's `targetPort` does not reference the container's debug port, so traffic doesn't reach the container.

Actual behavior

The Service `targetPort` is templated as `{{ .Values.opencost.debugPort }}` which is undefined.

Expected behavior

The Service `targetPort` should reference `{{ .Values.opencost.exporter.debugPort }}` so it maps to the container port defined for the exporter.

Proposed fix

Update `charts/opencost/templates/service.yaml` replacing:

```yaml
targetPort: {{ .Values.opencost.debugPort }}
```

with:

```yaml
targetPort: {{ .Values.opencost.exporter.debugPort }}
```

Severity: High — breaks debugging when enabled.

Optional: I can open this issue on GitHub for you, or create a small PR to fix the template. To open the issue automatically I will need `gh` CLI available and authenticated, or a GitHub token.
