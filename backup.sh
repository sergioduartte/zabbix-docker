#/bin/bash

#EDITE AS INFORMACOES ANTES DE REALIZAR O BACKUP

CONTAINER=mysql-zabbix
PASSWORD_ROOT=segredo
PATH_DE_DESTINO=/home/sergio/zabbix/backup
DATA=`date +%Y-%m-%d`

docker exec mysql-zabbix /usr/bin/mysqldump -uroot --password=$PASSWORD_ROOT zabbix > $PATH_DE_DESTINO/zabbix-$DATA.sql

echo "done"
