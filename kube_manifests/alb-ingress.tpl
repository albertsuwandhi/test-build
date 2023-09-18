apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: http-${REPONAME}
  namespace: ${NAMESPACE}
  annotations:
    alb.ingress.kubernetes.io/load-balancer-name: ${CLUSTER_NAME}-alb
    alb.ingress.kubernetes.io/scheme: internet-facing
    alb.ingress.kubernetes.io/target-type: ip # ip vs instance
    # alb.ingress.kubernetes.io/backend-protocol: HTTPS 
    alb.ingress.kubernetes.io/listen-ports: '[{"HTTPS":443}, {"HTTP":80}]'
    # alb.ingress.kubernetes.io/ssl-policy: ELBSecurityPolicy-TLS-1-1-2017-01 #Optional (Picks default if not used)
    # Redirect HTTP to HTTPS
    alb.ingress.kubernetes.io/ssl-redirect: '443'  
    # Health Check Settings
    alb.ingress.kubernetes.io/healthcheck-protocol: HTTP 
    alb.ingress.kubernetes.io/healthcheck-port: traffic-port
    alb.ingress.kubernetes.io/healthcheck-path: /
    # Important Note: Need to add health check path annotations in service level if we are planning to use multiple targets in a load balancer    
    alb.ingress.kubernetes.io/healthcheck-interval-seconds: '15'
    alb.ingress.kubernetes.io/healthcheck-timeout-seconds: '5'
    alb.ingress.kubernetes.io/success-codes: '200'
    alb.ingress.kubernetes.io/healthy-threshold-count: '2'
    alb.ingress.kubernetes.io/unhealthy-threshold-count: '2' 
    # Ingress Groups
    alb.ingress.kubernetes.io/group.name: ${CLUSTER_NAME}-alb
    # alb.ingress.kubernetes.io/group.order: '${INGRESS_GROUP_ORDER}'   
spec:
  ingressClassName: alb
  rules:
    - host: ${APP_URL} # Option 1
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: ${SVC_NAME}
                port:
                  number: ${SVC_PORT}