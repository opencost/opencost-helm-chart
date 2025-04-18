{{/*
Expand the name of the chart.
*/}}
{{- define "opencost-parquet-exporter.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "opencost-parquet-exporter.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "opencost-parquet-exporter.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create default image tag taken from the AppVersion.
*/}}
{{- define "opencost-parquet-exporter.imageTag" -}}
{{ .Values.image.tag | default (printf "%s" .Chart.AppVersion) }}
{{- end }}

{{- define "opencost-parquet-exporter.fullImageName" -}}
{{ .Values.image.repository -}}:{{ include "opencost-parquet-exporter.imageTag" . }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "opencost-parquet-exporter.labels" -}}
helm.sh/chart: {{ include "opencost-parquet-exporter.chart" . }}
{{ include "opencost-parquet-exporter.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "opencost-parquet-exporter.selectorLabels" -}}
app.kubernetes.io/name: {{ include "opencost-parquet-exporter.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
