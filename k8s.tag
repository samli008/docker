#make local docker repository

sed -i '/ExecStart/a\--insecure-registry 192.168.6.121:4000 \\' /usr/lib/systemd/system/docker.service

systemctl daemon-reload
systemctl restart docker

for i in $(docker images |grep k8s|awk '{print $1":"$2}');do echo $i;done

k8s.gcr.io/kube-proxy:v1.15.0
k8s.gcr.io/kube-apiserver:v1.15.0
k8s.gcr.io/kube-controller-manager:v1.15.0
k8s.gcr.io/kube-scheduler:v1.15.0
k8s.gcr.io/coredns:1.3.1
k8s.gcr.io/kubernetes-dashboard-amd64:v1.10.1
k8s.gcr.io/etcd:3.3.10
k8s.gcr.io/flannel:v0.10.0-amd64
k8s.gcr.io/pause:3.1

for i in $(docker images |grep k8s|awk '{print $1":"$2}');do echo $i;docker tag $i "192.168.6.121:4000$(echo $i |awk -F '.io' {'print $2'})";done


for i in `docker images |grep 192 |awk '{print $1":"$2}'`;do echo $i;done

192.168.6.121:4000/kube-proxy:v1.15.0
192.168.6.121:4000/kube-apiserver:v1.15.0
192.168.6.121:4000/kube-scheduler:v1.15.0
192.168.6.121:4000/kube-controller-manager:v1.15.0
192.168.6.121:4000/coredns:1.3.1
192.168.6.121:4000/kubernetes-dashboard-amd64:v1.10.1
192.168.6.121:4000/etcd:3.3.10
192.168.6.121:4000/flannel:v0.10.0-amd64
192.168.6.121:4000/pause:3.1

for i in `docker images |grep 192 |awk '{print $1":"$2}'`;do echo $i;docker push $i;done
