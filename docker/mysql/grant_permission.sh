#!/bin/bash

MYSQL_ROOT_PWD="mysql"
MYSQL_USER="jlawyer"
MYSQL_USER_PWD="jlawyer"
MYSQL_USER_DB="jlawyerdb"

# MYSQL_USER_DB=j$MYSQL_USER
# MYSQL_ROOT_PWD=$MYSQL_ROOT_PASSWORD
# MYSQL_ROOT_PWD=$MYSQL_ROOT_PASSWORD

if [ -n "$MYSQL_USER_DB" ]; then
    echo "[i] Creating database: $MYSQL_USER_DB"
    mysql --user=root --password=$MYSQL_ROOT_PWD -e "CREATE DATABASE IF NOT EXISTS \`$MYSQL_USER_DB\` CHARACTER SET utf8 COLLATE utf8_general_ci; FLUSH PRIVILEGES;"
    if [ -n "$MYSQL_USER" ] && [ -n "$MYSQL_USER_PWD" ]; then
	echo "[i] Create new User: $MYSQL_USER with password $MYSQL_USER_PWD for new database $MYSQL_USER_DB."
	mysql --user=root --password=$MYSQL_ROOT_PWD -e "GRANT ALL PRIVILEGES ON \`$MYSQL_USER_DB\`.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_USER_PWD' WITH GRANT OPTION; FLUSH PRIVILEGES;"
    else
	echo "[i] Don\`t need to create new User."
    fi
else
    if [ -n "$MYSQL_USER" ] && [ -n "$MYSQL_USER_PWD" ]; then
	echo "[i] Create new User: $MYSQL_USER with password $MYSQL_USER_PWD for all database."
	mysql --user=root --password=$MYSQL_ROOT_PWD -e "GRANT ALL PRIVILEGES ON *.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_USER_PWD' WITH GRANT OPTION; FLUSH PRIVILEGES;"
    else
	echo "[i] Don\`t need to create new User."
    fi
fi
