#!/bin/bash

# 定义变量
LOCAL_DIR=./public  # 要压缩的本地目录
REMOTE_DIR=/opt/1panel/apps/openresty/openresty/www/sites/200502.xyz/index  # 服务器上的目标目录
TAR_FILE=hexo.tar.gz  # 压缩文件名
echo "生成网页"
hexo clean
hexo g

# 1. 压缩本地目录
echo "开始压缩本地目录..."
cd $LOCAL_DIR && tar -czf ../$TAR_FILE *
if [ $? -ne 0 ]; then
    echo "压缩失败！"
    exit 1
fi
echo "压缩完成！"

cd ..

echo "开始删除远程目录文件"
ssh az-sg "cd $REMOTE_DIR && rm -rf $REMOTE_DIR/*"
if [ $? -ne 0 ]; then
    echo "删除失败"
    exit 1
fi
echo "删除完成!"

echo "开始上传到服务器..."
scp $TAR_FILE az-sg:$REMOTE_DIR
if [ $? -ne 0 ]; then
    echo "上传失败！"
    exit 1
fi
echo "上传完成！"

echo "开始在服务器上解压..."
ssh az-sg "cd $REMOTE_DIR && tar -xzf $TAR_FILE"
if [ $? -ne 0 ]; then
    echo "解压失败！"
    exit 1
fi
echo "解压完成！"

echo "完成！"
