apiVersion: v1
kind: Secret
metadata:
  name: doppler-token-secret-${REPONAME}
  namespace: doppler-operator-system
type: Opaque
data:
  serviceToken : ${DOPPLER_TOKEN}
