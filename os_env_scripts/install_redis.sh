#!/bin/bash

# 设置颜色变量
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -e "${GREEN}# 更新软件列表${NC}"
sudo apt update
sudo apt upgrade -y

echo -e "${GREEN}# 安装redis server${NC}"
sudo apt install redis-server -y


echo -e "${GREEN}# 查看redis 版本${NC}"
redis-cli --version

echo -e "${GREEN}# mysql 开机启动启动${NC}"
sudo systemctl enable redis-server

echo -e "${GREEN}# 验证 mysql 服务是否在运行${NC}"
sudo systemctl status redis-server



# 修改redis conf
# sudo vim /etc/redis/redis.conf

# update requirepass
# requirepass 123456

# update bind address
# bind 127.0.0.1 192.168.31.35


# 重启
# sudo systemctl restart redis-server