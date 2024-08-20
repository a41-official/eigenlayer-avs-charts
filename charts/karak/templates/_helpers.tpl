{{/*
Expand the name of the chart.
*/}}
{{- define "karak.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "karak.fullname" -}}
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
{{- define "karak.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "karak.labels" -}}
helm.sh/chart: {{ include "karak.chart" . }}
{{ if .Values.commonLabels -}}
{{- toYaml .Values.commonLabels }}
{{ end -}}
{{ include "karak.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "karak.selectorLabels" -}}
app.kubernetes.io/name: {{ include "karak.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "karak.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "karak.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
ServiceMonitor relabelings
*/}}
{{- define "karak.serviceMonitorRelabelings" -}}
{{- if .Values.serviceMonitor.enabled -}}
- action: replace
  targetLabel: chain
  replacement: karak
- action: replace
  targetLabel: avs
  replacement: karak
- action: replace
  targetLabel: network
  replacement: {{ tpl .Values.network $ }}
{{- end -}}
{{- end -}}