#!/bin/bash

# Adding NGINX Repo
echo "Adding NGINX Repo" && \
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx \

# Installing NGINX Ingress
echo "Installing NGINX Ingress" && \
cd terraform && \
helm install nginx-ingress ingress-nginx/ingress-nginx \
	--version 4.14.1 \
	--namespace nginx-ingress \
	--create-namespace 

# Installing External DNS
echo "Installing External DNS" && \
helm install external-dns oci://registry-1.docker.io/bitnamicharts/external-dns -f helm-values/external-dns.yaml \
    --set image.repository=bitnamilegacy/external-dns \
    --set image.tag=0.18.0-debian-12-r4 \
     --namespace external-dns \
    --create-namespace \

# Adding External Secrets Operator repo
echo "Adding External Secrets Operator repo" && \
helm repo add external-secrets https://charts.external-secrets.io \

# Installing External Secrets Operator
echo "Installing External Secrets Operator" && \
helm install external-secrets external-secrets/external-secrets \
    --version 1.3.1 \
    --namespace external-secrets \
    --create-namespace \

# Installing Certificate Manager
echo "Installing Certificate Manager" && \
helm install cert-manager oci://quay.io/jetstack/charts/cert-manager -f helm-values/cert-manager.yaml \
    --version v1.19.2 \
    --namespace cert-manager \
    --create-namespace \
    --set crds.enabled=true

# Applying the issuer
echo "Applying the issuer" && \
cd .. && \
kubectl apply -f cert-man/issuer.yaml \

# Adding KubePromStack repo
echo "Adding KubePromStack repo" && \
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts \

# Installing Kube-Prometheus-Stack
echo "Installing Kube-Prometheus-Stack" && \
cd terraform && \
helm install kube-prometheus-stack prometheus-community/kube-prometheus-stack -f helm-values/prom-stack.yaml \
    --version 81.1.0 \
    --namespace kube-prometheus-stack \
    --create-namespace \

# Creating the hedgedoc-app namespace
echo "Creating the hedgedoc-app namespace" && \
cd .. && \
kubectl create namespace hedgedoc-app  \

# Applying Secret Store Yaml
echo "Applying Secret Store Yaml" && \
kubectl apply -f secrets-manager/secret-store.yaml \

# Applying External Secret Yaml
echo "Applying External Secret Yaml" && \
kubectl apply -f secrets-manager/external-secret.yaml \

# Applying S3 External Secret Yaml
echo "Applying S3 External Secret Yaml" && \
kubectl apply -f secrets-manager/external-secret-s3.yaml \

# Adding ArgoCD repo
echo "Adding ArgoCD repo" && \
helm repo add argo https://argoproj.github.io/argo-helm \

# Installing ArgoCD
echo "Installing ArgoCD" && \
cd terraform && \
helm install argo-cd argo/argo-cd -f helm-values/argocd.yaml \
    --version 9.3.4 \
    --namespace argo-cd \
	--set crds.enabled=true \
    --create-namespace \

# Applying the Argo App
echo "Applying the Argo App" && \
cd .. && \
kubectl apply -f argo-cd/apps-argo.yaml \

