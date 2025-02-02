---
title: 哪吒探针v1在部分国内vps上安装失败
date: 2025-01-14 19:35:05
updated: 2025-01-14 19:35:05
tags:
---
在金华和金华的电信vps上，安装哪吒探针会提示
```
Download nezha-agent release failed, check your network connectivity
```
这是由于哪吒探针的安装脚本在检测到国内网络后，会从gitee上下载应用程序
```sh
    if [ -z "$CN" ]; then
        NZ_AGENT_URL="https://${GITHUB_URL}/nezhahq/agent/releases/latest/download/nezha-agent_${os}_${os_arch}.zip"
    else
        _version=$(curl -m 10 -sL "https://gitee.com/api/v5/repos/naibahq/agent/releases/latest" | awk -F '"' '{for(i=1;i<=NF;i++){if($i=="tag_name"){print $(i+2)}}}')
        NZ_AGENT_URL="https://${GITHUB_URL}/naibahq/agent/releases/download/${_version}/nezha-agent_${os}_${os_arch}.zip"
    fi
```
可以看到，当脚本检测到是国内时，会先从gitee上获取最新的哪吒探针版本写入到_version，但是在金华和江苏的电信网络上，会提示
```
403 Forbidden (Rate Limit Exceeded)
```
这导致没法获取到版本信息。
只需要手动在电脑上执行一下命令，获取到最新脚本，再把脚本中的_version变量写成版本号即可解决
```
curl -m 10 -sL "https://gitee.com/api/v5/repos/naibahq/agent/releases/latest" | awk -F '"' '{for(i=1;i<=NF;i++){if($i=="tag_name"){print $(i+2)}}}'
```sh
    if [ -z "$CN" ]; then
        NZ_AGENT_URL="https://${GITHUB_URL}/nezhahq/agent/releases/latest/download/nezha-agent_${os}_${os_arch}.zip"
    else
        _version=v1.5.6
        NZ_AGENT_URL="https://${GITHUB_URL}/naibahq/agent/releases/download/${_version}/nezha-agent_${os}_${os_arch}.zip"
    fi
```
