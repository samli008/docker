modprobe ip_vs
read -p "pls input vip[192.168.50.111]: " vip
read -p "pls input master hostname: " host
docker run --net=host \
--cap-add=NET_ADMIN \
--name keepalived \
-e VIRTUAL_IP=$vip \
-e VIRTUAL_ROUTER_ID=52 \
-e STATE=`[ $HOSTNAME = "$host" ] && echo MASTER || echo BACKUP` \
-e PRIORITY=`[ $HOSTNAME = "$host" ] && echo 101 || echo 100` \
--restart=always \
-d keepalived
