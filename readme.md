## 批量创建sftp用户

# 1、conf/start.sh  
     创建用户，新加用户，sftp会重构，重新添加用户

# 2、ssh_key
     对应用户key   user_authorized_keys 的模式。

# 3、重构命令
     docker-compose stop && docker-compose rm 
     docker-compose up -d

# 4、删除常用命令，保证sftp安全     