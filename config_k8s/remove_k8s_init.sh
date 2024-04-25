#!/bin/bash

echo "reset k8s master..."

sudo kubeadm reset
sudo rm -rf ~/.kube/config
sudo rm -rf /etc/kubernetes/manifests
sudo rm -rf /var/lib/etcd

echo "reset done! Pls rerun k8s init ... "
