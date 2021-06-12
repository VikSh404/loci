#!/bin/bash
export KUBERNETES_ADDRESS=192.168.88.99
for instance in $(ls -1 *worker-[012].pem | sed 's/\(.*\)\.pem/\1/g'); do
kubectl config set-cluster k8sthw \
      --certificate-authority=ca.pem \
      --embed-certs=true \
      --server=https://${KUBERNETES_ADDRESS}:6443 \
      --kubeconfig=${instance}.kubeconfig
kubectl config set-credentials system:node:${instance} \
      --client-certificate=${instance}.pem \
      --client-key=${instance}-key.pem \
      --embed-certs=true \
      --kubeconfig=${instance}.kubeconfig
kubectl config set-context default \
      --cluster=k8sthw \
      --user=system:node:${instance} \
      --kubeconfig=${instance}.kubeconfig
kubectl config use-context default --kubeconfig=${instance}.kubeconfig
done

{
kubectl config set-cluster k8sthw \
      --certificate-authority=ca.pem \
      --embed-certs=true \
      --server=https://${KUBERNETES_ADDRESS}:6443 \
      --kubeconfig=kube-proxy.kubeconfig
kubectl config set-credentials system:kube-proxy \
      --client-certificate=kube-proxy.pem \
      --client-key=kube-proxy-key.pem \
      --embed-certs=true \
      --kubeconfig=kube-proxy.kubeconfig
kubectl config set-context default \
      --cluster=k8sthw \
      --user=system:kube-proxy \
      --kubeconfig=kube-proxy.kubeconfig
kubectl config use-context default --kubeconfig=kube-proxy.kubeconfig
}


{
kubectl config set-cluster k8sthw \
      --certificate-authority=ca.pem \
      --embed-certs=true \
      --server=https://127.0.0.1:6443 \
      --kubeconfig=kube-controller-manager.kubeconfig
kubectl config set-credentials system:kube-controller-manager \
      --client-certificate=kube-controller-manager.pem \
      --client-key=kube-controller-manager-key.pem \
      --embed-certs=true \
      --kubeconfig=kube-controller-manager.kubeconfig
kubectl config set-context default \
      --cluster=k8sthw \
      --user=system:kube-controller-manager \
      --kubeconfig=kube-controller-manager.kubeconfig
kubectl config use-context default --kubeconfig=kube-controller-manager.kubeconfig
}

{
kubectl config set-cluster k8sthw \
      --certificate-authority=ca.pem \
      --embed-certs=true \
      --server=https://127.0.0.1:6443 \
      --kubeconfig=kube-scheduler.kubeconfig
kubectl config set-credentials system:kube-scheduler \
      --client-certificate=kube-scheduler.pem \
      --client-key=kube-scheduler-key.pem \
      --embed-certs=true \
      --kubeconfig=kube-scheduler.kubeconfig
kubectl config set-context default \
      --cluster=k8sthw \
      --user=system:kube-scheduler \
      --kubeconfig=kube-scheduler.kubeconfig
kubectl config use-context default --kubeconfig=kube-scheduler.kubeconfig
}


{
kubectl config set-cluster k8sthw \
      --certificate-authority=ca.pem \
      --embed-certs=true \
      --server=https://127.0.0.1:6443 \
      --kubeconfig=admin.kubeconfig
kubectl config set-credentials admin \
      --client-certificate=admin.pem \
      --client-key=admin-key.pem \
      --embed-certs=true \
      --kubeconfig=admin.kubeconfig
kubectl config set-context default \
      --cluster=k8sthw \
      --user=admin \
      --kubeconfig=admin.kubeconfig
kubectl config use-context default --kubeconfig=admin.kubeconfig
}
