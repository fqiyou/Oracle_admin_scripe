#!/etc/bash
#!用本地源运行oracle-rdbms-server-11gR2-preinstall

#复制到 /tmp

#1. 加载DVD安装盘：注意光驱位置 可用df -lh 查看 我的虚拟机中为 /dev/sr0 
mkdir -p /media/disk
mount /dev/sr0 /media/disk
#mount -t iso9660 -o loop /tmp/image.iso /media/disk 

#加入 /etc/rc.local
grep "mount /dev/sr0 /media/disk" /etc/rc.local >/dev/null
if [ $? -ne 0 ];then
    echo "mount /dev/sr0 /media/disk" >>/etc/rc.local
fi


#2. 修改 /usr/lib/python2.6/site-packages/yum/yumRepo.py
#   remote = url + '/' + relative 为 remote = "file:///media/disk/Server/" + '/' + relative
#   
cd /usr/lib/python2.6/site-packages/yum/
sed -i 's/remote.*relative$/remote\ =\ "file:\/\/\/media\/disk\/Server\/"\ +\ relative/g' yumRepo.py

#3. 修改/etc/yum.repos.d/public-yum-ol6.repo
cd /etc/yum.repos.d/
# wget http://public-yum.oracle.com/public-yum-ol6.repo
sed -i 's/baseurl.*$/baseurl=file:\/\/\/media\/disk\/Server\//g' public-yum-ol6.repo
sed -i 's/enabled.*$/enabled=1/g' public-yum-ol6.repo
sed -i 's/gpgcheck.*$/gpgcheck=0/g' public-yum-ol6.repo
cat /etc/yum.repos.d/public-yum-ol6.repo

#4. 安装依赖包
yum -y install oracle-rdbms-server-11gR2-preinstall

#安装其它需要的包
yum -y install lrzsz tigervnc-server

# 使用其中命令
#yum clean all
#yum makecache
#yum update