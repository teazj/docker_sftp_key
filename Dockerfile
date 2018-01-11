FROM centos:7.4.1708
MAINTAINER  zhang.jian@chinaebi.com
COPY ssh_key /root/ssh_key
COPY conf/start.sh /start.sh
COPY conf/sshd_config /etc/ssh/sshd_config 
RUN rm -f /etc/localtime && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime &&\
    yum -y install openssh-server openssh>/dev/null 2>&1 &&\
    yum clean all &&\ 
    rm -rf /var/cache/* &&\ 
    groupadd sftp &&\
    ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key &&\
    ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key &&\
    mkdir /var/run/sshd &&\
    chmod -R 600 /root/ssh_key &&\
    chmod 600 /etc/ssh/sshd_config  &&\
    chmod 500 /start.sh
ENTRYPOINT ["/start.sh"]
VOLUME /var/sftp
EXPOSE 9822
CMD ["/usr/sbin/sshd","-D"]
