#!/bin/sh

# ����Ĭ������
rm -rf /etc/config/ddns
rm -rf /etc/config/wireless

cp /root/ddns /etc/config/ddns
cp /root/wireless /etc/config/wireless


# ɾ������Ҫ��
rm -rf /root/*

mkdir /home
chmod 0755 /home

# ����һ��
reboot

exit 0