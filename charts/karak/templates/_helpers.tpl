{{/*
Expand the name of the chart.
*/}}
{{- define "eoracle.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "eoracle.fullname" -}}
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
{{- define "eoracle.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "eoracle.labels" -}}
helm.sh/chart: {{ include "eoracle.chart" . }}
{{ if .Values.commonLabels -}}
{{- toYaml .Values.commonLabels }}
{{ end -}}
{{ include "eoracle.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "eoracle.selectorLabels" -}}
app.kubernetes.io/name: {{ include "eoracle.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "eoracle.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "eoracle.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
ServiceMonitor relabelings
*/}}
{{- define "eoracle.serviceMonitorRelabelings" -}}
{{- if .Values.serviceMonitor.enabled -}}
- action: replace
  targetLabel: chain
  replacement: eigenlayer
- action: replace
  targetLabel: avs
  replacement: eoracle
- action: replace
  targetLabel: network
  replacement: {{ tpl .Values.network $ }}
{{- end -}}
{{- end -}}