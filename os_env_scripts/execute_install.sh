
#!/bin/bash

# 步骤 1: 将当前目录下所有 install_ 开头的文件赋予执行权限
for file in install_*; do
    if [ -f "$file" ]; then
        chmod +x "$file"
        echo "Added execute permission to $file"
    fi
done

# 步骤 2: 执行所有 install_ 开头的脚本
for script in install_*; do
    if [ -f "$script" ] && [ -x "$script" ]; then
        echo "Executing $script"
        ./"$script"
    fi
done
