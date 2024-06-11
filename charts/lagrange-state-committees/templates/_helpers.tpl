{{/*
Expand the name of the chart.
*/}}
{{- define "lagrange-state-committees.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "lagrange-state-committees.fullname" -}}
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
{{- define "lagrange-state-committees.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "lagrange-state-committees.labels" -}}
helm.sh/chart: {{ include "lagrange-state-committees.chart" . }}
{{ include "lagrange-state-committees.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "lagrange-state-committees.selectorLabels" -}}
app.kubernetes.io/name: {{ include "lagrange-state-committees.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the service account name for the lagrange-state-committees chart.
If a service account name is provided in the values and it is not an empty string, use that name.
Otherwise, use the full name template with a '-sa' suffix.
*/}}
{{- define "lagrange-state-committees.serviceAccountName" -}}
{{- if and .Values.serviceAccount.name (ne (trim .Values.serviceAccount.name) "") }}
{{- .Values.serviceAccount.name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-sa" (include "lagrange-state-committees.fullname" . | trunc 63) | trimSuffix "-" }}
{{- end }}
{{- end }}
