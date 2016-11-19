#!/bin/sh

# vi /etc/sysctl.conf
cat>>/etc/sysctl.conf<< EOF2
# oracle sysctl.conf
# Writer: Y
fs.aio-max-nr = 1048576
fs.file-max = 6815744
kernel.shmall = 2097152
kernel.shmmax = 4294967295
kernel.shmmni = 4096
kernel.sem = 250 32000 100 128
net.ipv4.ip_local_port_range = 9000 65500
net.core.rmem_default = 262144
net.core.rmem_max = 4194304
net.core.wmem_default = 262144
net.core.wmem_max = 1048586
EOF2
if (( $? == 0 ));then
        echo " sysctl.conf  add success"
        echo " Pleace vi /etc/sysctl.conf"
else
        echo " sysctl.conf  add error"
fi
