#!/bin/sh
# dir and user
# Run as: root
# Writer: Y

ORACLE_BASE="/u01/app/oracle"
ORAINVENTORY_DIR="/u01/app/oraInventory"

mkdir -p $ORAINVENTORY_DIR
if (( $? == 0 ));then
        echo " mkdir $ORAINVENTORY_DIR  add success"
else
        echo " mkdir $ORAINVENTORY_DIR  add error"
fi
mkdir -p $ORACLE_BASE
if (( $? == 0 ));then
        echo " mkdir $ORACLE_BASE  add success"
else
        echo " mkdir $ORACLE_BASE  add error"
fi

chown -R oracle:oinstall $ORAINVENTORY_DIR
if (( $? == 0 ));then
        echo " chown $ORAINVENTORY_DIR  add success"
else
        echo " chown $ORAINVENTORY_DIR  add error"
fi
chown -R oracle:oinstall $ORACLE_BASE
if (( $? == 0 ));then
        echo " chown $ORACLE_BASE  add success"
else
        echo " chown $ORACLE_BASE  add error"
fi
chmod -R 775 $ORAINVENTORY_DIR
if (( $? == 0 ));then
        echo " chmod $ORAINVENTORY_DIR  add success"
else
        echo " chmod $ORAINVENTORY_DIR  add error"
fi
chmod -R 775 $ORACLE_BASE
if (( $? == 0 ));then
        echo " chmod $ORACLE_BASE  add success"
else
        echo " chmod $ORACLE_BASE  add error"
fi
