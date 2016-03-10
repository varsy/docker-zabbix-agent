#!/bin/bash

rccheck() {
   if [ $? != 0 ]; then
      echo "Error! Stopping the script."
      exit 1
   fi
}

if [ -z ${SERVER} ];  then
   echo "Error! Please specify the zabbix server address!"
   exit 1
fi

if [ -z ${METADATA} ]; then
   echo "Error! Please specify the metadata!"
   exit 1
fi


if [ -z ${HOST} ]; then
   sed -i "s/^Hostname=.*/Hostname=${METADATA}-`hostname`/" /etc/zabbix/zabbix_agentd.conf
else
   sed -i "s/^Hostname=.*/Hostname=${HOST}/" /etc/zabbix/zabbix_agentd.conf
fi

sed -i "s/^Server=.*/Server=${SERVER}/" /etc/zabbix/zabbix_agentd.conf
sed -i "s/^.*EnableRemoteCommands=0/EnableRemoteCommands=1/" /etc/zabbix/zabbix_agentd.conf
sed -i "s/^.*ListenIP=.*/ListenIP=0.0.0.0/" /etc/zabbix/zabbix_agentd.conf
sed -i "s/^.*StartAgents=3/StartAgents=0/" /etc/zabbix/zabbix_agentd.conf
sed -i "s/^ServerActive=.*/ServerActive=${SERVER}/" /etc/zabbix/zabbix_agentd.conf

sed -i "s/^# HostMetadata\=.*/HostMetadata\=${METADATA}/" /etc/zabbix/zabbix_agentd.conf

sed -i "s/^.*AllowRoot=0/AllowRoot=1/" /etc/zabbix/zabbix_agentd.conf

trap "service zabbix-agent stop" SIGINT SIGTERM SIGHUP
service zabbix-agent start ; rccheck

tail -qF /var/log/zabbix/zabbix_agentd.log &
wait
