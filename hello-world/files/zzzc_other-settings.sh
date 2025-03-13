#!/bin/sh

# 设置默认配置
rm -rf /etc/config/ddns
rm -rf /etc/config/wireless

cp /root/ddns /etc/config/ddns
cp /root/wireless /etc/config/wireless


# 删除不需要的
rm -rf /root/*

mkdir /home
chmod 0755 /home

# 重启一遍
reboot

exit 0