{{- define "witnesschain-watchtower.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "witnesschain-watchtower.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{- define "witnesschain-watchtower.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "witnesschain-watchtower.labels" -}}
helm.sh/chart: {{ include "witnesschain-watchtower.chart" . }}
{{ if .Values.commonLabels -}}
{{- toYaml .Values.commonLabels }}
{{ end -}}
{{- include "witnesschain-watchtower.selectorLabels" . }}
app.kubernetes.io/managed-by: {{ .Release.Service -}}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote -}}
{{- end -}}
{{- end -}}

{{- define "witnesschain-watchtower.selectorLabels" -}}
app.kubernetes.io/name: {{ include "witnesschain-watchtower.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{- define "witnesschain-watchtower.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
{{- if and .Values.serviceAccount.name (ne (trim .Values.serviceAccount.name) "") -}}
{{- .Values.serviceAccount.name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-sa" (include "witnesschain-watchtower.name" .) -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{- define "witnesschain-watchtower.serviceMonitorRelabelings" -}}
{{- if .Values.serviceMonitor.enabled -}}
- action: replace
  targetLabel: chain
  replacement: eigenlayer
- action: replace
  targetLabel: avs
  replacement: witnesschain-watchtower
- action: replace
  targetLabel: network
  replacement: {{ tpl .Values.network $ }}
{{- end -}}
{{- end -}}