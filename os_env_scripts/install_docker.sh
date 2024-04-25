#!/bin/bash

# 设置颜色变量
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -e "${GREEN}# 安装必要的证书和工具${NC}"
sudo apt install apt-transport-https ca-certificates curl software-properties-common gnupg lsb-release -y

echo -e "${GREEN}# 添加 Docker 的官方 GPG 密钥${NC}"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

sleep 10

echo -e "${GREEN}# 添加 Docker 官方库${NC}"
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sleep 10
echo -e "${GREEN}# 更新 Ubuntu 源列表${NC}"
sudo apt update

echo -e "${GREEN}# 安装 Docker 相关软件包${NC}"
sudo apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y


echo -e "${GREEN}# 验证 Docker 服务是否在运行${NC}"
sudo systemctl status docker --no-pager status docker

