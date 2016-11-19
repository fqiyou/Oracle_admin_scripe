#!/bin/sh

# vi /home/oracle/.bash_profile
cat>>/home/oracle/.bash_profile<< EOF3
# add oracle bash_profile
# Writer: Y 
umask 022
export ORACLE_BASE=/u01/app/oracle
export ORACLE_HOME=\$ORACLE_BASE/product/11.2.0/dbhome_1
export ORACLE_SID=orcl
export TERM=xterm
export ORA_NLS33=/oracle/db/product/11.2.0/db_1/data
export LD_LIBRARY_PATH=\$ORACLE_HOME/lib:\$ORACLE_HOME/rdbms/lib:/lib:/usr/lib
export PATH=\$ORACLE_HOME/bin:/usr/bin:/etc/:/usr/sbin:/usr/ucb:/sbin:\$ORACLE_HOME/OPach:/bin:/usr/css/bin:\$PATH
export CLASSPATH=\$ORACLE_HOME/JRE:\$ORACLE_HOME/jlib:\$ORACLE_HOME/rdbms/jlib;
EOF3
if (( $? == 0 ));then
	echo " bash_profile  add success"
	echo " Pleace vi /home/oracle/.bash_profile"
else
	echo " bash_profile  add error"
fi
