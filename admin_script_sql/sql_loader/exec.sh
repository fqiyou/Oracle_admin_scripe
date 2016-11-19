#!/bin/sh

nohup sqlldr userid=hr/hr control=./emp.ctl log=./emp.log direct=true &