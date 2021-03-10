#/bin/bash

#EDITE AS INFORMACOES ANTES DE REALIZAR O RESTORE

CONTAINER=mysql-zabbix
PASSWORD_ROOT=segredo
PATH_DE_ORIGEM=/home/sergio/zabbix/backup
DATA=`date +%Y-%m-%d`


#sobe os containers
docker-compose up -d

# tempo médio para os servicos subirem até poder serem parados, talvez isso nao seja necessario
sleep 10

# parando containers para poder restaurar o banco
docker stop zabbix-server zabbix-web 

# remove o banco
docker exec mysql-zabbix /usr/bin/mysql -uroot --password=$PASSWORD_ROOT -e 'drop database zabbix'

# recria o banco
docker exec mysql-zabbix /usr/bin/mysql -uroot --password=$PASSWORD_ROOT -e 'create database zabbix'

# restaura o banco
docker exec -i mysql-zabbix /usr/bin/mysql -uroot --password=$PASSWORD_ROOT --database=zabbix < $PATH_DE_DESTINO/zabbix-$DATA.sql


# restarta os servicos
docker start zabbix-server zabbix-web 

echo "done"
