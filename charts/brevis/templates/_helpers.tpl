{{- define "brevis.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "brevis.fullname" -}}
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

{{- define "brevis.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "brevis.labels" -}}
helm.sh/chart: {{ include "brevis.chart" . }}
{{ if .Values.commonLabels -}}
{{- toYaml .Values.commonLabels }}
{{ end -}}
{{- include "brevis.selectorLabels" . }}
app.kubernetes.io/managed-by: {{ .Release.Service -}}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote -}}
{{- end -}}
{{- end -}}

{{- define "brevis.selectorLabels" -}}
app.kubernetes.io/name: {{ include "brevis.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{- define "brevis.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
{{- if and .Values.serviceAccount.name (ne (trim .Values.serviceAccount.name) "") -}}
{{- .Values.serviceAccount.name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-sa" (include "brevis.name" .) -}}
{{- end -}}
{{- end -}}
{{- end -}}
