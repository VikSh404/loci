#!/bin/bash
# /C=US
# /ST=Moscow area
# /L=Moscow
# /O=Free Loci Group
# /OU=Organizational Unit Name
# /CN=ROOT CA

#rm -f *ca* *json* *pem* *csr* *.kubeconfig
# rm -rf ssl/ config/ || true
# mkdir ssl/ configs/ || true
{
cat > ca-config.json << EOF
{
"signing": {
  "default": { "expiry": "8760h" },
    "profiles": {
      "kubernetes": { "usages": ["signing", "key encipherment", "server auth", "client auth"], "expiry": "8760h"}
    }
}
}
EOF

cat > ca-csr.json << EOF
{
  "CN": "Kubernetes",
  "key": { "algo": "rsa", "size": 2048 },
  "names": [{"C": "RU","L": "Moscow", "O": "Loci LAB", "OU": "Loci install k8s the HW", "ST": "Moscow area"}]
}
EOF

cfssl gencert -initca ca-csr.json | cfssljson -bare ca
}


# generate the admin client certificate
{
cat > admin-csr.json << EOF
{
"CN": "admin", "key": { "algo": "rsa", "size": 2048},
"names": [ { "C": "RU", "L": "Moscow", "O": "system:masters", "OU": "Loci install k8s the HW", "ST": "Moscow area" } ]
}
EOF
cfssl gencert \
-ca=ca.pem \
-ca-key=ca-key.pem \
-config=ca-config.json \
-profile=kubernetes \
admin-csr.json | cfssljson -bare admin
}
# generate the kubelet client certificates
for i in {0..2}
do
export WORKER_HOST=k8sthw-worker-${i}
export WORKER_IP=192.168.88.8$(( ${i} + 3 ))

cat > ${WORKER_HOST}-csr.json << EOF
{
"CN": "system:node:${WORKER_HOST}",
"key": { "algo": "rsa", "size": 2048 },
"names": [{ "C": "RU", "L": "Moscow", "O": "system:nodes", "OU": "Loci install k8s the HW", "ST": "Moscow area"}]
}
EOF
cfssl gencert \
-ca=ca.pem \
-ca-key=ca-key.pem \
-config=ca-config.json \
-hostname=${WORKER_IP},${WORKER_HOST} \
-profile=kubernetes \
${WORKER_HOST}-csr.json | cfssljson -bare ${WORKER_HOST}

done

# generate the client certificate for the kube-controller-manager
{
cat > kube-controller-manager-csr.json << EOF
{
"CN": "system:kube-controller-manager", 
"key": { "algo": "rsa", "size": 2048 },
"names": [ { "C": "RU", "L": "Moscow", "O": "system:kube-controller-manager", "OU": "Loci install k8s the HW", "ST": "Moscow area" } ]}
EOF
cfssl gencert \
-ca=ca.pem \
-ca-key=ca-key.pem \
-config=ca-config.json \
-profile=kubernetes \
kube-controller-manager-csr.json | cfssljson -bare kube-controller-manager
}



{
cat > kube-proxy-csr.json << EOF
{
"CN": "system:kube-proxy",
"key": { "algo": "rsa", "size": 2048 },
"names": [ { "C": "RU", "L": "Moscow", "O": "system:node-proxier", "OU": "Loci install k8s the HW", "ST": "Moscow area" }]
}
EOF
cfssl gencert \
-ca=ca.pem \
-ca-key=ca-key.pem \
-config=ca-config.json \
-profile=kubernetes \
kube-proxy-csr.json | cfssljson -bare kube-proxy
}

# generate the client certificate for the kube-scheduler


{
cat > kube-scheduler-csr.json << EOF
{
"CN": "system:kube-scheduler",
"key": { "algo": "rsa", "size": 2048 },
"names": [ { "C": "RU", "L": "Moscow", "O": "system:kube-scheduler", "OU": "Loci install k8s the HW", "ST": "Moscow area" } ]
}
EOF
cfssl gencert \
-ca=ca.pem \
-ca-key=ca-key.pem \
-config=ca-config.json \
-profile=kubernetes \
kube-scheduler-csr.json | cfssljson -bare kube-scheduler
}


# generate the Kubernetes API server certificate
# default CERT_HOSTNAME for controllers:
export CERT_HOSTNAME=10.32.0.1,kubernetes.default,127.0.0.1,localhost
# adding proxy/lb k8sthw-proxy-0,192.168.88.99 (if we use it)
export CERT_HOSTNAME=${CERT_HOSTNAME},k8sthw-proxy-0,192.168.88.99
# adding controllers master nodes
for i in {0..2}
do
export CERT_HOSTNAME=${CERT_HOSTNAME},k8sthw-controller-${i},192.168.88.8${i}
done
echo ${CERT_HOSTNAME}
{
cat > kubernetes-csr.json << EOF
{
"CN": "kubernetes",
"key": { "algo": "rsa", "size": 2048 },
"names": [ { "C": "RU", "L": "Moscow", "O": "Kubernetes", "OU": "Loci install k8s the HW", "ST": "Moscow area" } ]
}
EOF
cfssl gencert \
-ca=ca.pem \
-ca-key=ca-key.pem \
-config=ca-config.json \
-hostname=${CERT_HOSTNAME} \
-profile=kubernetes \
kubernetes-csr.json | cfssljson -bare kubernetes
}


# generate a Kubernetes service account key pair
{
cat > service-account-csr.json << EOF
{
"CN": "service-accounts",
"key": { "algo": "rsa", "size": 2048 },
"names": [ { "C": "RU", "L": "Moscow", "O": "Kubernetes", "OU": "Loci install k8s the HW", "ST": "Moscow area" } ]
}
EOF
cfssl gencert \
-ca=ca.pem \
-ca-key=ca-key.pem \
-config=ca-config.json \
-profile=kubernetes \
service-account-csr.json | cfssljson -bare service-account
}
