#!/usr/bin/env bash
# USAGE:
# 	Prerequisites:
# 		- Requires the Oracle XE 11G RPM downloaded to the server. The path to the download needs to be repalced with <PATH_TO_ORACLE_XE_11G>.
# 		- Substitute <DATABASE_PASSWORD> with desired Oracle server password. 

PATH_TO_ORACLE_XE_11G=/vagrant/Disk1
DATABASE_PASSWORD=vagrant

# Provision
echo "Installing Libaio"
yum install libaio -y
echo "Installing BC"
yum install bc -y
echo "Installing Net-Tools"
yum install net-tools -y
echo "Installing GCC"
yum install gcc -y
echo "Installing GLibC"
yum glibc -y
echo "Installing Make"
yum make -y
echo "Installing BinUtils"
yum binutils -y

# Increase swapspace
echo "Increasing Swapspace"
dd if=/dev/zero of=/swapfile count=1024 bs=1M
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
cp /etc/fstab /etc/fstab_bak
echo '/swapfile	swap	swap	sw	0	0' >> /etc/fstab
echo "Resized Swapspace:"
grep SwapTotal /proc/meminfo

# Install Oracle (Input password for database)
echo "Running Installation"
# rpm -ivh oracle-xe-11.2.0-1.0.x86_64.rpm
rpm -ivh $PATH_TO_ORACLE_XE_11G/oracle-xe-11.2.0-1.0.x86_64.rpm
echo '#!/usr/bin/expect
spawn /etc/init.d/oracle-xe configure
expect "Specify the HTTP port that will be used for Oracle Application Express [8080]:" {send "\n}"
expect "Specify a port that will be used for the database listener [1521]:" {send "\n}"
expect "initial configuration:" {send "$DATABASE_PASSWORD"}
expect "Confirm the password:" {send "$DATABASE_PASSWORD"}
expect "Do you want Oracle Database 11g Express Edition to be started on boot (y/n) [y]:"{send "\n"}
interact
' > configure_oracle.exp
chmod +x configure_oracle.exp && ./configure_oracle.exp

. /u01/app/oracle/product/11.2.0/xe/bin/oracle_env.sh

# To enable remote access
# sqlplus system
# login
# exec DBMS_XDB.SETLISTENERLOCALACCESS(FALSE);