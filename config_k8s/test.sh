#!/bin/bash

FILE="/etc/docker/daemon.json"

# 判文件吗是否存在
if [ ! -e "$FILE" ]; then
  # 文件不存在，创建文件并写入空json对象
  echo '{}' > "$FILE"
fi

# 现在文件必定存在，检查是否为空或者包含{}空json
if [ ! -s "$FILE" ] || [ "$(cat "$FILE")" = '{}' ]; then
  # 文件为空，写入空json对象
  echo '{}' > "$FILE"
fi

# 检查json是否包含`insecure-registries`字段
if ! jq -e '.["insecure-registries"]' "$FILE" >/dev/null; then
  # 不存在，添加`insecure-registries`字段
  jq '.["insecure-registries"]=["registry.k8s.io"]' "$FILE" > "$FILE.tmp" && mv "$FILE.tmp" "$FILE"
else
  # 如果字段存在但不包括registry.k8s.io，则添加
  if ! jq -e '.["insecure-registries"] | contains(["registry.k8s.io"])' "$FILE" >/dev/null; then
    # 添加"registry.k8s.io"至数组
    jq '.["insecure-registries"] += ["registry.k8s.io"]' "$FILE" > "$FILE.tmp" && mv "$FILE.tmp" "$FILE"
  fi
fi

echo "完成更新 '$FILE'."
