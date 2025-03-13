#!/bin/sh  
  
# 清空原网络配置  
echo "" > /etc/config/network  
  
# 写入新内容，其中 gateway、ipaddr、dns，这三项自己按需修改。如果你的VPS使用DHCP获取IP，建议也配置使用static方式获取，以免发生意外  
# 此配置禁用了ipv6  
  
echo "config interface 'loopback'  
        option ifname 'lo'  
        option proto 'static'  
        option ipaddr '127.0.0.1'  
        option netmask '255.0.0.0'   
  
config interface 'lan'  
        option type 'bridge'  
        option ifname 'eth0'  
        option proto 'static'  
        option netmask '255.255.255.0'  
        option ipaddr '192.168.1.2'  
        option gateway '192.168.1.1'  
        option dns '192.168.1.1'  

config interface 'lan6'
	option _orig_ifname 'eth0'
	option _orig_bridge 'false'
	option proto 'dhcpv6'
	option reqaddress 'try'
	option reqprefix 'auto'
	option delegate '0'
	option ifname '@lan'

config device 'lan_eth0_dev'  
        option name 'eth0'  
        option macaddr '24:cf:24:04:e4:15'  
  
config device 'wan_eth1_dev'  
        option name 'eth1'  
        option macaddr '24:cf:24:04:e4:14'  
  
config switch  
        option name 'switch0'  
        option reset '1'  
        option enable_vlan '1'  
  
config switch_vlan  
        option device 'switch0'  
        option vlan '1'  
        option vid '1'  
        option ports '0 1 2 4 6' " > /etc/config/network  
  
# 清空原防火墙配置  
echo "" > /etc/config/firewall  
  
# 写入新内容  
echo "config defaults  
        option syn_flood '1'  
        option input 'ACCEPT'  
        option output 'ACCEPT'  
        option forward 'ACCEPT'  
        option fullcone '0'  
  
config zone  
        option name 'lan'  
        list network 'lan'  
        option input 'ACCEPT'  
        option output 'ACCEPT'  
        option forward 'ACCEPT'  
  
config include  
        option path '/etc/firewall.user'  
  
config include 'miniupnpd'  
        option type 'script'  
        option path '/usr/share/miniupnpd/firewall.include'  
        option family 'any'  
        option reload '1' "> /etc/config/firewall  
  
# 清空源ssh配置  
echo "" > /etc/config/dropbear  
  
# 写入新配置，Port请修改为自己需要的端口。  
# SSH服务默认绑定了lan口，本文中使用了wan口，此配置为绑定所有接口  
echo "config dropbear  
        option PasswordAuth 'on'  
        option RootPasswordAuth 'on'  
        option Port         '33022'  
        option Interface    'lan'" > /etc/config/dropbear  
  
# BBR
echo "" > /etc/config/turboacc
echo "
config turboacc 'config'
	option sw_flow '1'
	option hw_flow '1'
	option sfe_flow '1'
	option fullcone_nat '2'
	option hw_wed '0'
	option dns_caching '0'
	option bbr_cca '1'
" > /etc/config/turboacc
 

# 清空UHTTP配置
echo "" > /etc/config/uhttpd

# 写入新配置
echo "config uhttpd 'main'
        list listen_http '0.0.0.0:33080'
        list listen_http '[::]:33080'
        option home '/www'
        option rfc1918_filter '1'
        option max_requests '3'
        option max_connections '100'
        option cgi_prefix '/cgi-bin'
        list lua_prefix '/cgi-bin/luci=/usr/lib/lua/luci/sgi/uhttpd.lua'
        option script_timeout '60'
        option network_timeout '30'
        option http_keepalive '20'
        option tcp_keepalive '1'
        option ubus_prefix '/ubus'
        list index_page 'cgi-bin/luci'" > /etc/config/uhttpd

  
exit 0