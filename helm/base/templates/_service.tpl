{{- define "base.service.tpl" -}}
apiVersion: v1
kind: Service
metadata:
  name: '{{ .Values.name }}'
  labels:
    app: '{{ .Values.name }}'
spec:
  type: {{ (.Values.service).type }}
  ports:
    - name: http
      port: 80
      protocol: {{ ((.Values.service).port).protocol }}
      targetPort: {{ ((.Values.service).port).targetPort }}
    - name: https
      port: 443
      protocol: {{ ((.Values.service).port).protocol }}
      targetPort: {{ ((.Values.service).port).targetPort }}
  selector:
    app: '{{ .Values.name }}'
{{- end }}
{{- define "base.service" -}}
{{- include "base.util.merge" (append . "base.service.tpl") -}}
{{- end -}}