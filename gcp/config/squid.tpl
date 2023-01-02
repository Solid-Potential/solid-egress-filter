hosts_file /etc/hosts
acl all src 0.0.0.0/0.0.0.0
acl localhost src 127.0.0.1/255.255.255.255
acl to_localhost dst 127.0.0.0/8
acl CONNECT method CONNECT

# connection to http, https and ssl
acl Safe_ports port 80
acl Safe_ports port 443
acl SSL_ports port 22

acl src_whitelist srcdomain "/etc/squid/src_whitelist.txt"
acl dst_whitelist dstdomain "/etc/squid/dst_whitelist.txt"
acl lan src ${cidr}
acl my_phisical src 31.182.219.133

http_access allow src_whitelist
http_access allow dst_whitelist
http_access allow CONNECT
http_access deny CONNECT !SSL_ports
http_access deny !Safe_ports

http_access allow localhost
http_access allow lan
http_access allow my_phisical
http_access deny all
http_reply_access allow all
http_port 3128 transparent
coredump_dir /var/spool/squid