mfsmaster start
sleep 10
for i in {1..3};do ssh n$i mkdir /data;done
for i in {1..3};do ssh n$i chown mfs:mfs /data;done
for i in {1..3};do ssh n$i "echo MASTER_HOST=n1 >> /etc/mfs/mfschunkserver.cfg";done
for i in {1..3};do ssh n$i "echo /data >> /etc/mfs/mfshdd.cfg";done
for i in {1..3};do ssh n$i mfschunkserver start;done
for i in {1..3};do ssh n$i mkdir /mfs;done
for i in {1..3};do ssh n$i mfsmount -H n1 /mfs;done
