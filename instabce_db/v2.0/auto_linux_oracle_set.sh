#!/bin/sh
#   Copyright (C) 2017 All rights reserved.
#   Filename:auto_linux_oracle_set.sh
#   Author  :yangchao
#   Mail    :yc@fqiyou.com
#   Date    :2017-03-09
#   Describe:
#######################################################

# 0.0 Check rpm package installed
# rpm -q ocfs2-tools  oracleasm-support binutils ksh compat-libstdc++-33 elfutils-libelf elfutils-libelf-devel glibc glibc-common glibc-devel glibc-headers gcc gcc-c++ libaio-devel libaio libgcc libstdc++ libstdc++-devel make sysstat unixODBC unixODBC-devel | grep "not installed"
# eq: yum install -y  unixODBC unixODBC-devel

ORACLE_BASE="/app/application/oracle"
ORAINVENTORY_DIR="/app/application/oraInventory"
USER_PASSWD="fqiyou"

# 1.0 define oracle install dir
if [ -z $ORACLE_BASE  ] && [ -z $ORAINVENTORY_DIR  ] ;then
	echo "your need define oracle dir,please open this setting ORACLE_BASE and ORAINVENTORY_DIR ..."
	exit 0
fi


# 2.0 create user and group
# groups : oinstall dba
# users : oracle
function add_user(){
	id oracle >/dev/null
	if [ $? -ne 0 ];then
		useradd -u 5001 -g oinstall -G dba $1
		echo $USER_PASSWD | passwd --stdin $1 
		echo "$1 create user success ... "
	else
		usermod -g oinstall -G dba $1
		echo $USER_PASSWD | passwd --stdin $1 
		echo "$1 update user success ... "
	fi
}
function add_group(){
	grep "$1" /etc/group >/dev/null
	if [ $? -ne 0 ];then
		groupadd  -g $2 $1
	fi
}
add_group oinstall 5001
add_group dba 5002
add_user oracle

# 3.0 create dir and grant to user
function mkdir_dir(){
	if [ ! -d $1 ]; then
		mkdir -p $1
	fi
	chown -R oracle:oinstall $1
	chmod -R 775 $1
}
mkdir_dir $ORACLE_BASE
mkdir_dir $ORAINVENTORY_DIR


# 4.0 Edit /etc/sysctl.conf
# modprobe bridge
# [root@fqiyouApp etc]# /sbin/sysctl -p>/dev/null
# error: "net.bridge.bridge-nf-call-ip6tables" is an unknown key
# error: "net.bridge.bridge-nf-call-iptables" is an unknown key
# error: "net.bridge.bridge-nf-call-arptables" is an unknown key
function sed_sysctl(){
	VALUE=$(grep "^[ ]*$1" /etc/sysctl.conf | awk -F"[ ]*=[ ]*" '{print $2}')   
	if [ "-$VALUE" == "-" ]; then
		echo "$1 = $2">>/etc/sysctl.conf
	elif [ "-$VALUE" != "-$2" ]; then
		sed -i "s/^[ ]*$1.*$/$1=$2/g" /etc/sysctl.conf  
	fi
}
modprobe bridge
sed_sysctl "fs.aio-max-nr" "1048576"
sed_sysctl "fs.file-max" "6815744"
sed_sysctl "kernel.shmall" "2097152"
sed_sysctl "kernel.shmmax" "4294967295"
sed_sysctl "kernel.shmmni" "4096"
sed_sysctl "kernel.sem" "250 32000 100 128"
sed_sysctl "net.ipv4.ip_local_port_range" "9000 65500"
sed_sysctl "net.core.rmem_default" "262144"
sed_sysctl "net.core.rmem_max" "4194304"
sed_sysctl "net.core.wmem_default" "262144"
sed_sysctl "net.core.wmem_max" "1048586"

/sbin/sysctl -p>/dev/null
if [ $? -ne 0 ];then
	echo "Edit sysctl.conf $1 failure"
	exit 0
else
	echo "Edit sysctl.conf sucessfull" 
fi

# 5.0 Edit /etc/security/limits.conf
function add_limits(){
	VALUE=$(grep "^[ ]*$1.*$2.*$3" /etc/security/limits.conf | awk -F" *" '{print $4}')
	if [ "-$VALUE" == "-" ];then
		echo "$1 $2 $3 $4" >>/etc/security/limits.conf
	elif [ "-$VALUE" != "-$4" ];then
		sed -i "s/^[ ]*$1.*$2.*$3.*$/$1 $2 $3 $4/g" /etc/security/limits.conf
	fi
}
add_limits "oracle" "soft" "nproc" "2047"
add_limits "oracle" "hard" "nproc" "16384"
add_limits "oracle" "soft" "nofile" "1024"
add_limits "oracle" "hard" "nofile" "65536"
grep -E "nproc|nofile" /etc/security/limits.conf |grep -v "#">/dev/null
if [ $? -eq 0 ];then
	echo "Edit /etc/security/limits.conf "
fi

# 6.0 Edit ~oracle/.bash_profile
grep "ORACLE_SID" ~oracle/.bash_profile >/dev/null
if [ $? -ne 0 ];then
	sed -i "s/^PATH=\$PATH:\$HOME\/bin$//g" ~oracle/.bash_profile
	sed -i "s/^export\ PATH$//g" ~oracle/.bash_profile
	echo "umask 022">>~oracle/.bash_profile
	echo "export ORACLE_BASE=$ORACLE_BASE">>~oracle/.bash_profile
	echo "export ORACLE_HOME=\$ORACLE_BASE/product/11.2.0/dbhome_1">>~oracle/.bash_profile
	echo "export ORACLE_SID=orcl">>~oracle/.bash_profile
	echo "export TERM=xterm">>~oracle/.bash_profile
	echo "export ORA_NLS33=\$ORACLE_HOME/nls/data">>~oracle/.bash_profile
	echo "export LD_LIBRARY_PATH=\$ORACLE_HOME/lib:\$ORACLE_HOME/rdbms/lib:/lib:/usr/lib">>~oracle/.bash_profile
	echo "export PATH=\$ORACLE_HOME/bin:/usr/bin:/etc/:/usr/sbin:/usr/ucb:/sbin:\$ORACLE_HOME/OPach:/bin:/usr/css/bin:\$PATH">>~oracle/.bash_profile
	echo "export CLASSPATH=\$ORACLE_HOME/JRE:\$ORACLE_HOME/jlib:\$ORACLE_HOME/rdbms/jlib">>~oracle/.bash_profile
fi

# 7.0 Edit /etc/selinux/config
sed -i 's/^ *SELINUX *=.*$/SELINUX=disabled/g' /etc/selinux/config


