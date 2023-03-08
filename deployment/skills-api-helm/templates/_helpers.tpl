{{/*
Expand the name of the chart.
*/}}
{{- define "skills-api.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "skills-api.fullname" -}}
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
{{- define "skills-api.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "skills-api.labels" -}}
helm.sh/chart: {{ include "skills-api.chart" . }}
{{ include "skills-api.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "skills-api.selectorLabels" -}}
app.kubernetes.io/name: {{ include "skills-api.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "skills-api.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "skills-api.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Read environment variables from a .env file and add them to a ConfigMap
*/}}
{{- define "skills-api.configmap.data" -}}
{{- $env := .Env }}
{{- $envFile := .Files.Get "../.env" }}
{{- $lines := splitList $envFile "\n" -}}
{{- range $key, $value := $lines -}}
    {{- $key := trim $key -}}
    {{- $value := trim $value -}}
{{- if and $key $value (ne $key "") (ne $value "") -}}
    {{- printf "%s: %s" ($key) (toString $value) | quote }}: {{- printf "%s" ($value) | quote }}
{{- end -}}
{{- end -}}
{{- end -}}
