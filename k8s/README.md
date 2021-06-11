# Loci project
**k8s**
<div>
<img src="https://upload.wikimedia.org/wikipedia/commons/0/00/Kubernetes_%28container_engine%29.png" width=13%>
</div>

## Tips.

Simplest example deploy via pipe
```bash
ansible@master-1:~$ kubectl get nodes -o=custom-columns=NAME:.metadata.name,IP:.status.addresses[0].address
NAME       IP
master-1   192.168.88.11
node-1     192.168.88.14
node-2     192.168.88.15
node-3     192.168.88.16
node-4     192.168.88.17
```

```bash
cat << EOF | kubectl create -f -
apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  containers:
  - name: nginx
    image: nginx
EOF
```
