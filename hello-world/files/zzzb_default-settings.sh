#!/bin/sh
# 设置空密码
# sed -i 's@.*CYXluq4wUazHjmCDBCqXF*@#&@g' /etc/shadow

# 修正终端不显示错误
# sed -i 's/${interface:+-i $interface}/# ${interface:+-i $interface}/g' /etc/init.d/ttyd

#  禁用ICMP # # 30分钟后，自动关闭SSH 和UHTTP功能
echo "" > /etc/rc.local

echo "mount -o remount rw /
# 禁止ICMP
echo 1 > /proc/sys/net/ipv4/icmp_echo_ignore_all
echo 1 > /proc/sys/net/ipv6/icmp/echo_ignore_all
# 30分钟后，自动关闭SSH 和UHTTP功能
(sleep 1800 && /etc/init.d/dropbear stop && /etc/init.d/uhttpd stop) &
exit 0" >> /etc/rc.local

exit 0