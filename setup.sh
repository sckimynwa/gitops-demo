#!/bin/sh

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White
Nc='\033[0m'

echo "${Yello} Setup Start. ${Nc}\n"

echo "${Green}1. Gcloud Container ${Nc}\n"
# gcloud auth login
# gcloud auth application-default login
gcloud container clusters get-credentials cluster-yeoul --region asia-northeast3-c

echo "\n${Green}2. Istio Setting ${Nc}\n"

istioctl install --set profile=default -y
kubectl label namespace default istio-injection=enabled

echo "\n${Green}3. Application Setting ${Nc}\n"

kubectl apply -f ./apps/kopring-demo.yaml
kubectl apply -f ./apps/next13-demo.yaml
kubectl apply -f ./istio/gateway.yaml

echo "\n${Green}4. Argo CD Setting ${Nc}\n"
# if not installed, add repo first
# helm repo add argo https://argoproj.github.io/argo-helm
# helm repo update
# helm install argo argo/argo-cd -n argo-cd -f ./argo-cd/values.yaml --wait

echo "\n${Yello} Setup Finished. ${Nc}\n"