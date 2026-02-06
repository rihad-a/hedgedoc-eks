addrepo-nginx:
	helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx \

install-nginx:
	cd terraform && \
	helm install nginx-ingress ingress-nginx/ingress-nginx \
		--version 4.14.1 \
		--namespace nginx-ingress \
		--create-namespace 

install-extdns:
	cd terraform && \
	helm install external-dns oci://registry-1.docker.io/bitnamicharts/external-dns -f helm-values/external-dns.yaml \
        --set image.repository=bitnamilegacy/external-dns \
        --set image.tag=0.18.0-debian-12-r4 \
         --namespace external-dns \
        --create-namespace \

install-certman:
	cd terraform && \
	helm install cert-manager oci://quay.io/jetstack/charts/cert-manager -f helm-values/cert-manager.yaml \
        --version v1.19.2 \
        --namespace cert-manager \
        --create-namespace \
        --set crds.enabled=true

apply-issuer:
	kubectl apply -f cert-man/issuer.yaml \

addrepo-kubepromstack:
	helm repo add prometheus-community \
    https://prometheus-community.github.io/helm-charts

install-kubepromstack:
	cd terraform && \
	helm install kube-prometheus-stack prometheus-community/kube-prometheus-stack -f helm-values/prom-stack.yaml \
        --version 81.1.0 \
        --namespace kube-prometheus-stack \
        --create-namespace \

addrepo-externalsecretsoperator:
	helm repo add external-secrets \
    https://charts.external-secrets.io

install-externalsecretsoperator:
	helm install external-secrets external-secrets/external-secrets \
        --version 1.3.1 \
        --namespace external-secret \
        --create-namespace \

apply-secretstoreyaml:
	kubectl apply -f secrets-manager/secret-store.yaml \

apply-clustersecretstoreyaml:
	kubectl apply -f secrets-manager/cluster-secret-store.yaml \

apply-externalsecretyaml:
	kubectl apply -f secrets-manager/external-secret.yaml \

apply-clusterexternalsecretyaml:
	kubectl apply -f secrets-manager/cluster-external-secret.yaml \

addrepo-argocd:
	helm repo add argo \
    https://argoproj.github.io/argo-helm

install-argocd:
	cd terraform && \
	helm install argo-cd argo/argo-cd -f helm-values/argocd.yaml \
        --version 9.3.4 \
        --namespace argo-cd \
        --create-namespace \
		--set crds.enabled=true \

apply-argoapp:
	kubectl apply -f argo-cd/apps-argo.yaml \

uninstall-nginx:
	helm uninstall nginx-ingress -n nginx-ingress \

delete-issuer:
	kubectl delete -f cert-man/issuer.yaml \

uninstall-certman: 
	helm uninstall cert-manager -n cert-manager \

deletecrd-certman:
	kubectl delete crd \
		challenges.acme.cert-manager.io \
		orders.acme.cert-manager.io \
    	certificaterequests.cert-manager.io \
    	certificates.cert-manager.io \
    	clusterissuers.cert-manager.io \
		issuers.cert-manager.io \

uninstall-kubepromstack:
	helm uninstall kube-prometheus-stack -n kube-prometheus-stack \

delete-argoapp:
	kubectl delete -f argo-cd/apps-argo.yaml \

uninstall-argocd:
	helm uninstall argo-cd -n argo-cd \

deletecrd-argocd:
	kubectl delete crd \
		applications.argoproj.io  \
    	applicationsets.argoproj.io \
    	appprojects.argoproj.io \

delete-externalsecretyaml:
	kubectl delete -f secrets-manager/external-secret.yaml \

delete-s3externalsecretyaml:
	kubectl delete -f secrets-manager/external-secret-s3.yaml \

delete-secretstoreyaml:
	kubectl delete -f secrets-manager/secret-store.yaml \

uninstall-externalsecretsoperator:
	helm uninstall external-secrets -n external-secrets \

uninstall-extdns:
	helm uninstall external-dns -n external-dns \

delete-allnamespaces:
	kubectl delete namespace \
    	argo-cd \
    	cert-manager \
    	external-dns \
    	external-secrets \
    	hedgedoc-app \
    	kube-prometheus-stack \
    	nginx-ingress \

delete-s3mediauploadfiles:
	aws s3 rm s3://s3-mediaupload --recursive \
 


 