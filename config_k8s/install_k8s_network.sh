#!/bin/bash

#安装k8s网络插件flannel
kubectl apply -f kube-flannel.yml

# 删除网络
#kubectl delete -f kube-flannel.yml
