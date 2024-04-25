#!/bin/bash


GREEN='\033[0;32m'
NC='\033[0m' # No Color

sudo apt update -y

echo -e "${GREEN}# 安装net-tools${NC}"
sudo apt-get install net-tools -y

echo -e "${GREEN}# 安装openssh server${NC}"
sudo apt install openssh-server -y


