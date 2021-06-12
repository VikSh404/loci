# Loci project
**k8s**
<div>
<img src="https://upload.wikimedia.org/wikipedia/commons/0/00/Kubernetes_%28container_engine%29.png" width=13%>
</div>

Create certificates:
```bash
./create-all-keys.sh
```

Create configure files:
```bash
./create-all-configs.sh
```

Test ETCD:
```bash
sudo ETCDCTL_API=3 etcdctl member list \
--endpoints=https://127.0.0.1:2379 \
--cacert=/etc/etcd/ca.pem \
--cert=/etc/etcd/kubernetes.pem \
--key=/etc/etcd/kubernetes-key.pem
EOF
```

k8s heathcheck:
```bash
http://127.0.0.1/healthz
curl -k https://127.0.0.1/healthz
curl -H "Host: kubernetes.default.svc.cluster.local" http://127.0.0.1/healthz
```
Proxy:
```bash
curl -k https://localhost:6443/version
```