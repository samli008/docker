read -p "pls input 1 to install_only or 2 to install_local_registry: " sel

if [ $sel == 1 ];then

rm -f /etc/yum.repos.d/*
cp docker.repo /etc/yum.repos.d/
yum -y install docker-ce

elif [ $sel == 2 ];then

read -p "pls input docker local registry ip: " ip
rm -f /etc/yum.repos.d/*
cp docker.repo /etc/yum.repos.d/
yum -y install docker-ce

sed -i "s/dockerd/& --insecure-registry $ip:4000/" /usr/lib/systemd/system/docker.service
systemctl daemon-reload
systemctl restart docker
systemctl enable docker
cat /usr/lib/systemd/system/docker.service |grep dockerd

else
echo "input error!"
fi
