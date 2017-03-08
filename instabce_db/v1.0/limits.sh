#!/bin/sh

# vi /etc/security/limits.conf
cat>>/etc/security/limits.conf<< EOF1
# oracle limits
# Writer: Y
oracle		soft	nproc	2047
oracle		hard	nproc	16384
oracle		soft	nofile	1024
oracle		hard	nofile	65536
EOF1
if (( $? == 0 ));then
        echo " limits.conf  add success"
else
        echo " limits.conf  add error"
fi
