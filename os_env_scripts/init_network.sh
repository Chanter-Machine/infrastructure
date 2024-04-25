#!/bin/bash

#### 使用教程：./generate_network_config.sh 20.13.83.41 20.13.83.1 20.100.10.7



# 检查参数
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <IP_ADDRESS> <GATEWAY> <DNS>"
    exit 1
fi

# 提取参数
IP_ADDRESS=$1
GATEWAY=$2
DNS=$3

# 获取以太网接口名称
eth_interface=$(ip -o -4 route show to default | awk '{print $5}')

# 生成网络配置文件
cat <<EOL > network-config.yaml
network:
  version: 2
  renderer: NetworkManager
  ethernets:
    $eth_interface:
      dhcp4: no
      addresses: [$IP_ADDRESS/24]
      gateway4: $GATEWAY
      nameservers:
        addresses: [$DNS]
EOL

echo "Network configuration file 'network-config.yaml' generated successfully."
