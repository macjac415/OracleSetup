#!/usr/bin/env bash
# 

LICENSE_KEY=https://app.box.com/s/ekshrs2yfc2n9py53fzhl9hdvcku2p78
DATABASE_USER_ID = <DATABASE_USERNAME>
DATABASE_PASSWORD = <DATABASE_PASSWORD>

wget https://app.box.com/s/ekshrs2yfc2n9py53fzhl9hdvcku2p78 -o unlimited_dev.key
wget https://app.box.com/s/1ie065okby1yqex011hrbn7ezn7fievx -o power_center_installer.tar

expect "Do you want to continue? (Y/N)" {send "\n"}
expect "Enter the choice(1, 2 or 3):" {send: "1\n"}
expect "Select the option to proceed : (Default : 3)" {send "3\n"}
expect ":" {send "1\n"}
expect ":" {send "1\n"}
expect ":" {send "2\n"}
expect "Press <Enter> to continue ..." {send "\n"}
expect "Enter the license key file (default :- /root/license.key) :" {send "<path>"} #Define path location
expect "Enter the installation directory (default :- /root/Informatica/9.6.1) :" {send "\n"}
expect "Press <Enter> to continue ..." {send "\n"}
expect ":" {send "1\n"}
expect ":" {send "1\n"}
expect ":" {send "1\n"}
expect "Port: (default :- 8443) :" {send "\n"}
expect ":" {send "1\n"}
echo "Starting Oracle Configuration"
expect ":" {send "1\n"}
expect "Database user ID: (default :- pcuser) :" {send"$DATABASE_USER_ID\n"}
expect "User password: :" {send "$DATABASE_PASSWORD\n"}
expect ":" {send "1\n"}
expect "Database address: (default :- pcuser:1521) :" {send "\n"}
expect "Database service name: (default :- pcservicename) :" {send "\n"}
