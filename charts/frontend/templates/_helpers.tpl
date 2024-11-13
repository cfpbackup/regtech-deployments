{{/*
Expand the name of the chart.
*/}}
{{- define "regtech-frontend.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "regtech-frontend.fullname" -}}
{{- if .Values.fullnameOverride }}
  {{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
  {{- $name := default .Chart.Name .Values.nameOverride }}
  {{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "regtech-frontend.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "regtech-frontend.labels" -}}
helm.sh/chart: {{ include "regtech-frontend.chart" . }}
{{ include "regtech-frontend.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/name: {{ include "regtech-frontend.fullname" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/instance: regtech-sbl
{{- end }}

{{/*
Selector labels
*/}}
{{- define "regtech-frontend.selectorLabels" -}}
app.kubernetes.io/name: {{ include "regtech-frontend.fullname" . }}
app.kubernetes.io/instance: regtech-sbl
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "regtech-frontend.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "regtech-frontend.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "prefix" -}}
{{- if ne .Release.Name "regtech-sbl" -}}
  {{ .Release.Name | printf "%s-" }}
{{- else -}}
  {{printf "" }}
{{- end -}}
{{- end -}}

{{- define "apiPrefix" -}}
{{- if and .Values.global (ne .Release.Name .Values.global.chartName) }}
  {{ .Release.Name | printf "%s-" }}
{{- else -}}
  {{printf "" }}
{{- end -}}
{{- end -}}