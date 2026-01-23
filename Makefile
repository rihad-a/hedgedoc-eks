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

install-kubepromstack:
	cd terraform && \
	helm install kube-prometheus-stack prometheus-community/kube-prometheus-stack -f helm-values/prom-stack.yaml \
        --version 81.1.0 \
        --namespace kube-prometheus-stack \
        --create-namespace \

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

uninstall-extdns:
	helm uninstall external-dns -n external-dns \

 


 