apiVersion: secrets.doppler.com/v1alpha1
kind: DopplerSecret
metadata:
  name: ${REPO_NAME}-dopplersecret
  namespace: doppler-operator-system
spec:
  tokenSecret: # Kubernetes service token secret (namespace defaults to doppler-operator-system)
    name: doppler-token-secret-${REPO_NAME}
  managedSecret: # Kubernetes managed secret (will be created if does not exist)
    name: ${REPO_NAME}-secret
    namespace: ${NAMESPACE}
