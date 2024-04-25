#!/bin/bash
# 开启调试模式，打印每条将要执行的命令
set -x

# 定义颜色变量
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# 更新 apt 包列表
echo -e "${GREEN}# 更新 apt 包索引 ${NC}"
sudo apt-get update

# 下载 Kubernetes 包仓库的公共签名密钥
echo -e "${GREEN}# 下载用于 Kubernetes 软件包仓库的公共签名密钥 ${NC}"
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

# 添加 Kubernetes apt 仓库
echo -e "${GREEN}# 添加 Kubernetes apt 仓库 ${NC}"
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

# 重新更新 apt 包列表
echo -e "${GREEN}# 更新 apt 包索引 ${NC}"
sudo apt-get update

# 安装 kubelet、kubeadm 和 kubectl
echo -e "${GREEN}# 安装 kubelet、kubeadm 和 kubectl ${NC}"
sudo apt-get install -y kubelet kubeadm kubectl

# 锁定其版本
echo -e "${GREEN}# 锁定 kubelet、kubeadm 和 kubectl 版本 ${NC}"
sudo apt-mark hold kubelet kubeadm kubectl

# 输出安装完成消息
echo -e "${GREEN}# Kubernetes v1.28 安装完成 ${NC}"

#开机启动k8s
echo -e "${g=GREEN}# enable and start k8s when booting"
sudo systemctl enable kubelet
sudo systemctl start kubelet
