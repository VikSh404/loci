cat << EOF | kubectl create -f -
kind: Service
apiVersion: v1
metadata:
  name: nginx-service
spec:
  selector:
    app: nginx
  ports:
   - protocol: TCP
     port: 80
     targetPort: 80
     nodePort: 30080
  type: NodePort
EOF