#!/bin/bash
# 开启调试模式，打印每条将要执行的命令
set -x

# 定义颜色变量
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# 关闭Swap
echo -e "${GREEN}# 关闭Swap ${NC}"
sudo swapoff -a

# 获取安装的k8s版本号
echo -e "${GREEN}# 获取镜像列表 ${NC}"
k8s_client_version=$(kubectl version --client | grep   "Client Version:"   | awk '{print $3}')


# 配置insecure https
DAEMON_CONFIG_FILE="/etc/docker/daemon.json"
INSECURE_REGISTRIES='{"insecure-registries":["registry.k8s.io"]}'

# 函数，用于向daemon.json文件添加不安全仓库
add_insecure_registry() {
    if [ -s "$DAEMON_CONFIG_FILE" ]; then
        # 检查是否具有jq工具进行json解析
        if ! command -v jq &> /dev/null; then
            echo "jq tool is not installed. Please install jq to proceed." >&2
            exit 1
        fi

        # 检查"insecure-registries"字段是否存在
        if jq '.["insecure-registries"]' "$DAEMON_CONFIG_FILE" &> /dev/null; then
            # 添加新的不安全仓库到现有字段
            jq '.["insecure-registries"] += ["registry.k8s.io"]' "$DAEMON_CONFIG_FILE" | sudo tee "$DAEMON_CONFIG_FILE" > /dev/null
        else
            # 添加"insecure-registries"字段
            jq '. += '"$INSECURE_REGISTRIES"'' "$DAEMON_CONFIG_FILE" | sudo tee "$DAEMON_CONFIG_FILE" > /dev/null
        fi
    else
        # 文件不存在或为空，直接添加内容
        echo "$INSECURE_REGISTRIES" | sudo tee "$DAEMON_CONFIG_FILE" > /dev/null
    fi
}

# 使用sudo执行函数
#sudo bash -c "$(declare -f add_insecure_registry); add_insecure_registry"

#复制到/etc/docker/daemon.json
sudo cp daemon.json /etc/docker/daemon.json

#docker restart
sudo systemctl restart docker

#sleep 10
sleep 10

# 获取镜像文件列表
echo -e "${GREEN}# 获取镜像列表 ${NC}"
required_images=$(kubeadm config images list)
for img in ${required_images[@]} ; do
        sudo docker pull $img
done


# 初始化Kubernetes Master节点
echo -e "${GREEN}# 初始化Kubernetes Master节点 ${NC}"
sudo kubeadm init --apiserver-advertise-address=20.13.83.55 --kubernetes-version=$k8s_client_version --image-repository=registry.k8s.io --service-cidr=10.96.0.0/16 --pod-network-cidr=10.224.0.0/16


echo "master node of k8s init done..."

echo "later you need to deploy pod networkd... "
