{{/*
Common labels
*/}}
{{- define "opencost-parquet-exporter.annotations" -}}
{{- if .Values.awsRolename }}
iam.amazonaws.com/role: {{ .Values.awsRolename }}
{{- end }}
{{- end }}
