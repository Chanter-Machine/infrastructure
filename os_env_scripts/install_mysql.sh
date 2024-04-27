#!/bin/bash

# 设置颜色变量
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -e "${GREEN}# 更新软件列表${NC}"
sudo apt update

echo -e "${GREEN}# 搜索mysql${NC}"
sudo apt search mysql-server


echo -e "${GREEN}# 安装mysql server${NC}"
sudo apt install -y mysql-server-8.0


echo -e "${GREEN}# 启动mysql${NC}"
sudo systemctl start mysql

echo -e "${GREEN}# mysql 开机启动启动${NC}"
sudo systemctl enable mysql

echo -e "${GREEN}# 验证 mysql 服务是否在运行${NC}"
sudo systemctl status mysql



# 登录mysql
# sudo mysql -u root

# 设置密码
# ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '123456';

# update user set host = '%' where user = 'root'  limit 1;

# 刷新缓存
# flush privileges;


# sudo nano /etc/mysql/mysql.conf.d/mysqld.cnf
# bind-address = 0.0.0.0