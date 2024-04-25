#!/bin/bash


k8s_client_version=$(kubectl version --client | grep   "Client Version:"   | awk '{print $3}')
echo $k8s_client_version
