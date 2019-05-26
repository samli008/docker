FROM centos
MAINTAINER liyang
RUN yum -y install ftp wget nfs-utils openssh-clients openssh-server iputils iproute passwd
RUN ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key
RUN ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_ecdsa_key
RUN ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_ed25519_key
RUN mkdir -p /root/.ssh && chown root:root /root && chmod 700 /root/.ssh
RUN echo 'root:liyang' | chpasswd
RUN echo "sshd:x:74:74:Privilege-separated SSH:/var/empty/sshd:/sbin/nologin" >> /etc/passwd
RUN echo "LC_ALL=en_US.UTF-8" >> /etc/environment
RUN localedef -c -i en_US -f UTF-8 en_US.UTF-8
RUN useradd -m liyang
RUN echo 'liyang:liyang' | chpasswd
RUN ssh-keygen -q -P '' -t dsa -f /root/.ssh/id_dsa
RUN cat /root/.ssh/id_dsa.pub >> /root/.ssh/authorized_keys
RUN sed -i 's/#   StrictHostKeyChecking ask/StrictHostKeyChecking no/g' /etc/ssh/ssh_config
ADD mfs.tar /root/
RUN cd /root/mfs && rpm -ivh *.* 
RUN rm -rf /root/mfs
COPY mfs.sh /root/
CMD /usr/sbin/init
