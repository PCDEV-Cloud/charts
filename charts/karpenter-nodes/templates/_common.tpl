{{/* vim: set filetype=mustache */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "karpenter-nodes.name" -}}
  {{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "karpenter-nodes.fullname" -}}
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

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "karpenter-nodes.chart" -}}
  {{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Return valid verion label
*/}}
{{- define "karpenter-nodes.versionLabelValue" -}}
{{ regexReplaceAll "[^-A-Za-z0-9_.]" .Chart.AppVersion "-" | trunc 63 | trimAll "-" | trimAll "_" | trimAll "." | quote }}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "karpenter-nodes.labels" -}}
helm.sh/chart: {{ include "karpenter-nodes.chart" .context }}
{{ include "karpenter-nodes.selectorLabels" (dict "context" .context "component" .component "name" .name)}}
app.kubernetes.io/version: {{ include "karpenter-nodes.versionLabelValue" .context }}
app.kubernetes.io/managed-by: {{ .context.Release.Service }}
{{- end}}

{{/*
Selector labels
*/}}
{{- define "karpenter-nodes.selectorLabels" -}}
{{- if .name -}}
app.kubernetes.io/name: {{ .name }}
{{ end -}}
app.kubernetes.io/instance: {{ .context.Release.Name }}
{{- if .component }}
app.kubernetes.io/component: {{ .component }}
{{- end }}
{{- end }}