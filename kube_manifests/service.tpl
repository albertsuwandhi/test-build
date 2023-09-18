apiVersion: v1
kind: Service
metadata:
  name: ${SVC_NAME}
  namespace: ${NAMESPACE}
  labels:
    run: ${SVC_NAME}
spec:
  selector:
    app: ${SVC_NAME}
  ports:
  - protocol: TCP
    port: ${SVC_PORT}
    targetPort: ${SVC_TARGETPORT}
  type: NodePort