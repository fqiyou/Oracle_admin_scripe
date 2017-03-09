#!/bin/sh
#   Copyright (C) 2017 All rights reserved.
#   Filename:auto_oel_rpm.sh
#   Author  :yangchao
#   Mail    :yc@fqiyou.com
#   Date    :2017-03-09
#   Describe:
#######################################################

CD_DIR=/dev/sro # df -lh 查看

# 1.0 加载DVD光盘, 挂载
# 非光驱
# mount -t iso9660 -o loop /tmp/image.iso /mnt/oel6/
mkdir -p $MOUNT_DIR
mount $CD_DIR /mnt/oel6 
grep "mount $CD_DIR /mnt/oel6" /etc/rc.local >/dev/null
if [ $? -ne 0 ];then
   echo "mount $CD_DIR /mnt/oel6">>/etc/rc.local
fi

# 2.0 修改/usr/lib/python2.6/site-packages/yum/yumRepo.py
#     remote = url + '/' + relative 为 remote = "file:///mnt/oel/Server/" + '/' + relative
sed -i 's/remote.*relative$/remote\ =\ "file:\/\/\/mnt\/oel6\/Server\/"\ +\ relative/g' /usr/lib/python2.6/site-packages/yum/yumRepo.py

# 3. 备份及修改/etc/yum.repos.d/public-yum-ol6.repo
# wget http://public-yum.oracle.com/public-yum-ol6.repo
cp /etc/yum.repos.d/public-yum-ol6.repo /etc/yum.repos.d/public-yum-ol6.repo_bak`date +%Y%m%d`
sed -i 's/baseurl.*$/baseurl=file:\/\/\/mnt\/oel6\/Server\//g' /etc/yum.repos.d/public-yum-ol6.repo
sed -i 's/enabled.*$/enabled=1/g' /etc/yum.repos.d/public-yum-ol6.repo
sed -i 's/gpgcheck.*$/gpgcheck=0/g' /etc/yum.repos.d/public-yum-ol6.repo

# 4.0 清空缓存,及yum其他命令
# yum clean all
# yum makecache
# yum update
yum clean all


