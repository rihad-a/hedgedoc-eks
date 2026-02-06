#!/bin/bash

# Uninstalling NGINX Ingress
echo "Uninstalling NGINX Ingress" && \
helm uninstall nginx-ingress -n nginx-ingress \

# Deleting issuer
echo "Deleting issuer" && \
kubectl delete -f cert-man/issuer.yaml \

# Uninstalling Certificate Manager
echo "Uninstalling Certificate Manager" && \
helm uninstall cert-manager -n cert-manager \

# Deleting Certificate Manager CRD's
echo "Deleting Certificate Manager CRD's" && \
kubectl delete crd \
	challenges.acme.cert-manager.io \
	orders.acme.cert-manager.io \
    certificaterequests.cert-manager.io \
    certificates.cert-manager.io \
    clusterissuers.cert-manager.io \
	issuers.cert-manager.io \

# Uninstalling Kube-Prometheus-Stack
echo "Uninstalling Kube-Prometheus-Stack" && \
helm uninstall kube-prometheus-stack -n kube-prometheus-stack \

# Deleting ArgoCD app
echo "Deleting ArgoCD app" && \
kubectl delete -f argo-cd/apps-argo.yaml \

# Uninstalling ArgoCD
echo "Uninstalling ArgoCD" && \
helm uninstall argo-cd -n argo-cd \

# Deleting ArgoCD CRD's
echo "Deleting ArgoCD CRD's" && \
kubectl delete crd \
	applications.argoproj.io  \
    applicationsets.argoproj.io \
    appprojects.argoproj.io \

# Deleting External Secret Yaml
echo "Deleting External Secret Yaml" && \
kubectl delete -f secrets-manager/external-secret.yaml \

# Deleting S3 External Secret Yaml
echo "Deleting S3 External Secret Yaml" && \
kubectl delete -f secrets-manager/external-secret-s3.yaml \

# Deleting Secret Store Yaml
echo "Deleting Secret Store Yaml" && \
kubectl delete -f secrets-manager/secret-store.yaml \

# Uninstalling External Secrets Operator
echo "Uninstalling External Secrets Operator" && \
helm uninstall external-secrets -n external-secrets \

# Uninstalling External DNS
echo "Uninstalling External DNS" && \
helm uninstall external-dns -n external-dns \

# Delete all namespaces
echo "Delete all namespaces" && \
kubectl delete namespace \
    argo-cd \
    cert-manager \
    external-dns \
    external-secrets \
    hedgedoc-app \
    kube-prometheus-stack \
    nginx-ingress \

# Deleting all the files of the S3 bucket dedicated to media uploads
echo "Deleting all the files of the S3 bucket dedicated to media uploads" && \
aws s3 rm s3://s3-mediaupload --recursive \
