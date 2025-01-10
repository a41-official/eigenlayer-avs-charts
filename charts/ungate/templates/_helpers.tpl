{{- define "ungate.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "ungate.fullname" -}}
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

{{- define "ungate.labels" -}}
helm.sh/chart: {{ include "ungate.chart" . }}
{{ if .Values.commonLabels -}}
{{- toYaml .Values.commonLabels }}
{{ end -}}
{{- include "ungate.selectorLabels" . }}
app.kubernetes.io/managed-by: {{ .Release.Service -}}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote -}}
{{- end -}}
{{- end -}}

{{- define "ungate.selectorLabels" -}}
app.kubernetes.io/name: {{ include "ungate.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{- define "ungate.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
{{- if and .Values.serviceAccount.name (ne (trim .Values.serviceAccount.name) "") -}}
{{- .Values.serviceAccount.name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-sa" (include "ungate.name" .) -}}
{{- end -}}
{{- end -}}
{{- end -}}
