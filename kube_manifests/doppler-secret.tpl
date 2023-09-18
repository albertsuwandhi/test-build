apiVersion: secrets.doppler.com/v1alpha1
kind: DopplerSecret
metadata:
  name: ${REPONAME}-dopplersecret
  namespace: doppler-operator-system
spec:
  tokenSecret: # Kubernetes service token secret (namespace defaults to doppler-operator-system)
    name: doppler-token-secret-${REPONAME}
  managedSecret: # Kubernetes managed secret (will be created if does not exist)
    name: ${REPONAME}-secret
    namespace: ${NAMESPACE}
