cat > haproxy.cfg << EOF
global
  log 127.0.0.1 local0
  log 127.0.0.1 local1 notice
  tune.ssl.default-dh-param 2048
defaults
  log global
  mode http
  option dontlognull
  timeout connect 5000ms
  timeout client  600000ms
  timeout server  600000ms
listen stats
    bind :9091
    mode http
    balance
    stats uri /haproxy_stats
    stats auth admin:admin
    stats admin if TRUE
frontend nginx-frontend
   mode tcp
   bind :80
   default_backend nginx-backend
backend nginx-backend
    mode tcp
    balance roundrobin
    stick-table type ip size 200k expire 30m
    stick on src
    server ceph1 192.168.50.11:80 check
    server ceph2 192.168.50.12:80 check
    server ceph3 192.168.50.13:80 check
EOF

docker run --name haproxy \
-v /root/haproxy.cfg:/usr/local/etc/haproxy/haproxy.cfg \
-p 81:80 \
--restart=always \
-d haproxy
