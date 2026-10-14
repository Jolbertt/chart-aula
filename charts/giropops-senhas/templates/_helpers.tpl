{{/* Criar as nossas tags */}}

{{- define "app.labels" -}}
app: {{ .labels.app | quote}}
env: {{ .labels.env | quote }}
live: {{ .labels.live | quote }}
{{- end -}}

{{/* Definir os limites de recursos */}}

{{- define "app.resources" -}}
requests:
  memory: {{ .resources.requests.memory | quote }}
  cpu: {{ .resources.requests.cpu | quote }}
limits:
  memory: {{ .resources.limits.memory | quote }}
  cpu: {{ .resources.limits.cpu | quote }}
{{- end -}}

{{/* Definir as portas dos containers */}}

{{- define "app.ports" -}}
{{- range .ports }}
- containerPort: {{ .port  }}
{{- end }}
{{- end -}}

{{/* Definindo os nossos configmaps*/}}
{{- define "database.configmap" -}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .component }}-dbconfig
data:
  app-config.yaml: |
   {{- toYaml .config | nindent 4 }}
{{- end -}}

{{/* Definindo os nossos configmaps observability*/}}
{{- define "observability.configmap" -}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .component }}-observability-config
data:
  app-config.json: |
    {{ toJson .config }}
{{- end -}}