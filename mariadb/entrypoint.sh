#!/bin/bash

#Arrancamos servicios
if [ -d /var/lib/mysql ]
then
	service mariadb start
	#Crea la base de datos si no existe
	mysql -uroot -e "CREATE DATABASE IF NOT EXISTS $DB"
	#Crea el usuario si no existe y le otorga permisos a la base de datos
	if [ $(mysql -uroot -D mysql -s -e "SELECT EXISTS(SELECT 1 FROM mysql.user WHERE user = '$DBUSER')") ]
	then
		mysql -uroot -e "GRANT ALL ON $DB.* TO '$DBUSER'@'%' IDENTIFIED BY '$DBPASS'"
		#Carga el dump
		mysql -uroot -D $DB < /root/webtoprint.sql
	fi
fi

exec bash -c "while true;do sleep 10;done"
