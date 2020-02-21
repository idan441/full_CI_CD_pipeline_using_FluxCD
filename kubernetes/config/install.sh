#!/bin/bash 


#This shell script will install all helm charts which are needed for the echo application project. 

#Important - To run this shell - you need that your terminal will be located at this "config" directory! ( cd config/ ) 



### Install nginx-ingress server and cert-manager - ###

#Install the nginx-ingress server helm chart
kubectl create namespace nginx-ingress
helm install ingress ./charts/nginx-ingress --namespace=nginx-ingress # this command defines a service named ingress and install the cahrt from the local directory ingress-nginx. 

#Install the cert-manager helm chart - 
kubectl apply --validate=false -f https://raw.githubusercontent.com/jetstack/cert-manager/v0.13.0/deploy/manifests/00-crds.yaml #First I need to install a CRD which will be used by cert-manager. CRD = costume resource definition. This means it makes a new resource type which is not "natural" in Kubernetes - and instead was made by the developers of cert-manager. In order for me to use it - It need to be installed! 
kubectl create namespace cert-manager
helm install cert-manager ./charts/cert-manager --namespace=cert-manager

#In order to configure the nginx-ingress you will need to define an ingress resource. This resource will send configuration to the ingress server and will make it work. 
kubectl apply -f ./yaml/ingress/echo.yaml 
kubectl apply -f ./yaml/issuer/acme.yaml 

# #Test to see everything works - 
# kubectl get ingresses.extensions --namespace=nginx-ingress
# helm list --all-namespaces # Supposed to show the two installed charts. 
# kubectl get certificate --all-namespaces  #SUpposed to show the created TLS key and in its state to write "TRUE" 
# #And try to surf to the website online! :) 


### Install FluxCD ### 
kubectl create namespace fluxcd
helm repo add fluxcd https://charts.fluxcd.io

helm upgrade -i flux fluxcd/flux --wait --namespace fluxcd --set git.url=git@github.com:idan441/echo_app_fluxcd.git
#Please note that in the following command I set the GitHub repository url - in case you want to change it just edit the url and re-run this command. 
#An important note - make sure to set the GitHub in SSH format!!! 

#Install helm operator - 
kubectl apply -f https://raw.githubusercontent.com/fluxcd/helm-operator/master/deploy/flux-helm-release-crd.yaml #Installing CRDs for the helm operator
helm upgrade -i helm-operator fluxcd/helm-operator --wait --namespace fluxcd --set git.ssh.secretName=flux-git-deploy --set helm.versions=v3
#A note - in the above command I set a git ssh secret name which is "flux-git-deploy" . This name needs to be configured at the GitHub repository. 
#If you want to use a different name - update it in the above command and re-run it. Also make sure to update it at GitHub! 

# #Checkpoint - get the public key to configure at GitHub. 
# #This key will allow connection between FluxCD and the GitHub repository. The private key is made by FluxCD as its resource created on k8s. With these commands you can get the public key - and you need to manually set it in GitHub. ( See ./kubernetes/README.md for further explanation. ) 
# #You need to use one of these commands, the output will be the same. 
# fluxctl identity --k8s-fwd-ns fluxcd #Will show you the secret key you need to configure at GitHub in order to allow FluxCD to connect to the GitHub repository
# kubectl -n fluxcd logs deployment/flux | grep identity.pub | cut -d '"' -f2 #You can also get the key with this command. 


### Install Mongodb ### 
#For this project there is a Mongo db installed on the k8s cluster. 
#The echo application is working with a Mongo database. (the echo production adn staging environments. ) They both use the same database but use different tables! 
#The login credentials and settings of the mongo db were set at the chart's value.yaml . 
kubectl create namespace mongodb
helm install mongodb ./charts/mongodb --namespace mongodb



### Install the yaml files needed to configure connect the application releases to the nginx-ingress server. Also, these files will configure the TLS connection of cert-manager. 
#If in a need to change domain or anything related to exposing the application to the web - please refer to these files and edit them. ( Every file has internal documentation relevant to it. ) 
kubectl apply -f ./yaml/ingress #Configures the domain and directory paths of the echo applications. 
kubectl apply -f ./yaml/issuer #Makes a SSL certificate by configuring cert-manager. 
kubectl apply -f ./yaml/service #ExternalName for the echo application, allowing to connect between the applications and the nginx server. 



### Install EFK - ElasticSEarch, Frond and Kibana ### 
# These charts are based on the following - https://akomljen.com/get-kubernetes-logs-with-efk-stack-in-5-minutes/ 
kubectl create namespace logging
helm install es-operator --namespace logging ./charts/elasticsearch-operator
helm install efk --namespace logging ./charts/efk



### Install Prometheus and Grafana - for monitoring ###
#This chart is the official chart - https://hub.helm.sh/charts/stable/prometheus 
kubectl create namespace prometheus
helm install prometheus --namespace prometheus ./charts/prometheus
#This chart is the offical chart - https://github.com/helm/charts/tree/master/stable/grafana
kubectl create namespace grafana
helm install prometheus --namespace grafana ./charts/grafana


