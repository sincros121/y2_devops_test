{{- define "base.deployment.tpl" -}}
apiVersion: apps/v1
kind: Deployment
metadata:
  name: '{{.Values.name}}'
  labels:
    app: '{{.Values.name}}'
spec:
  replicas: {{ .Values.replicas }}
  selector:
    matchLabels:
      app: '{{.Values.name}}'
  strategy:
    type: {{ .Values.deploymentStrategy }}
    rollingUpdate:
      maxSurge: "{{ .Values.maxSurge }}"
      maxUnavailable: "{{ .Values.maxUnavailable }}"
  template:
    metadata:
      labels:
        app: {{ .Values.name }}
      annotations:
        cluster-autoscaler.kubernetes.io/safe-to-evict: 'false'
    spec:
      {{- if hasKey .Values "toleration" }}
      tolerations:
      - key: "{{ .Values.toleration }}"
        operator: "Equal"
        value: "true"
      {{- end }}
      containers:
      - name: {{ .Values.name }}
        image: {{ .Values.global.repo }}/{{ .Values.name }}:{{ $.Values.image.tag }}
        imagePullPolicy: Always
        readinessProbe:
          tcpSocket:
            port: {{ .Values.service.port.targetPort }}
          initialDelaySeconds: 10
          periodSeconds: 10
        livenessProbe:
          tcpSocket:
            port: {{ .Values.service.port.targetPort }}
          initialDelaySeconds: 20
          periodSeconds: 10
        resources:
          requests:
            cpu:    {{ .Values.cpu }}
            memory: {{ .Values.memory }}
        ports:
          - containerPort: {{ .Values.service.port.targetPort }}
{{- end -}}
{{- define "base.deployment" -}}
{{- include "base.util.merge" (append . "base.deployment.tpl") -}}
{{- end -}}