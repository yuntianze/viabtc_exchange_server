#!/bin/bash

# 统计所有C/C++源文件大小
echo "=== Source Files Size Analysis ==="
find . -type f \( -name "*.c" -o -name "*.cpp" -o -name "*.h" -o -name "*.hpp" \) -not -path "./build/*" -not -path "./deps/*" | while read file; do
    # 获取文件大小并格式化输出
    size=$(ls -lh "$file" | awk '{print $5}')
    echo "$size  $file"
done

# 按目录统计大小
echo -e "\n=== Directory Size Summary ==="
for dir in src utils network; do
    if [ -d "$dir" ]; then
        size=$(du -sh "$dir" | cut -f1)
        echo "$size  ./$dir"
    fi
done

# 统计总代码大小（排除build和deps目录）
echo -e "\n=== Total Code Size ==="
find . -type f \( -name "*.c" -o -name "*.cpp" -o -name "*.h" -o -name "*.hpp" \) -not -path "./build/*" -not -path "./deps/*" -exec du -ch {} + | tail -n 1
