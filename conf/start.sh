#!/bin/bash
useradd_c(){
for i in {'abc','aaa','ccc'}
do
   if [[ ! `id $i` ]];then
     useradd -M -d /var/sftp/$i -G sftp $i -s /bin/false 
     mkdir -p /var/sftp/$i/{.ssh,data} 
     mkdir /root/.ssh && chmod 700 /root/.ssh 
     chown root:sftp /var/sftp/$i 
     chmod 755 /var/sftp/$i  
     cp /root/ssh_key/${i}_authorized_keys /var/sftp/$i/.ssh/authorized_keys
     cp /root/ssh_key/${i}_authorized_keys /root/.ssh/authorized_keys
     chmod 600 /root/.ssh/authorized_keys
     chown -R $i:$i /var/sftp/$i/data
     chown -R $i:$i /var/sftp/$i/.ssh
     chmod -R 700 /var/sftp/$i/.ssh
     chmod 600 /var/sftp/$i/.ssh/authorized_keys
     echo -e "Match User $i\n   ChrootDirectory /var/sftp/$i\n   ForceCommand    internal-sftp" >>/etc/ssh/sshd_config 
   fi
done
}
del_c(){
rm -rf /bin/chmod 
rm -rf /bin/rm
rm -rf /bin/mv
rm -rf /usr/bin/yum 
}
useradd_c
del_c
exec $1 $2
