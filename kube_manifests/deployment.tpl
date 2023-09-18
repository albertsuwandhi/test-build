apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-api
  namespace: ${NAMESPACE}
  labels:
    app: ${REPONAME}
spec:
  replicas: 1
  strategy:
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 1
    type: RollingUpdate
  selector:
    matchLabels:
      app: ${REPONAME}
  template:
    metadata:
      labels:
        app: ${REPONAME}
    spec:
      containers:
        - name: ${REPONAME}
          image: irllc/demo-app:ENV
          imagePullPolicy: Always
