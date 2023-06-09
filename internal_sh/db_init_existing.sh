#!/usr/bin/env bash
mysqld_safe &
sleep 2
mysql -e "CREATE DATABASE $MARIADB_DB;"
mysql -e "CREATE USER '$MARIADB_USER' IDENTIFIED BY '$MARIADB_PASS';";
mysql -e "GRANT ALL PRIVILEGES ON $MARIADB_DB.* TO '$MARIADB_USER'@'%' IDENTIFIED BY '$MARIADB_PASS' WITH GRANT OPTION;"
mysql -e "FLUSH PRIVILEGES;"
mysql "$MARIADB_DB"  < dump.sql