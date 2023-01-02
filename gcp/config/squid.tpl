hierarchy_stoplist cgi-bin ?
acl QUERY urlpath_regex cgi-bin \?
no_cache deny QUERY
hosts_file /etc/hosts
refresh_pattern ^ftp: 1440 20% 10080
refresh_pattern ^gopher: 1440 0% 1440
refresh_pattern . 0 20% 4320
acl all src 0.0.0.0/0.0.0.0
acl manager proto cache_object
acl localhost src 127.0.0.1/255.255.255.255
acl to_localhost dst 127.0.0.0/8
acl purge method PURGE
acl CONNECT method CONNECT

# connection to http and ssl
acl Safe_ports port 80
acl Safe_ports port 443
acl SSL_ports port 22

cache_mem 1024 MB
acl src_whitelist srcdomain "/etc/squid/src_whitelist.txt"
acl dst_whitelist dstdomain "/etc/squid/dst_whitelist.txt"

http_access allow src_whitelist
http_access allow dst_whitelist
http_access allow CONNECT
http_access deny CONNECT !SSL_ports
http_access allow manager localhost
http_access deny manager
http_access allow purge localhost
http_access deny purge
http_access deny !Safe_ports
acl lan src ${cidr}
acl my_phisical src 31.182.219.133

http_access allow localhost
http_access allow lan
http_access allow my_phisical
http_access deny all
http_reply_access allow all
icp_access allow all
http_port 3128 transparent
coredump_dir /var/spool/squid