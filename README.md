# docker-zabbix-agent

This is docker image with Zabbix 3.0 agent + autoregistration.

Docker image is located at [varsy/zabbix-agent](https://hub.docker.com/r/varsy/zabbix-agent/).

You could use the [varsy/zabbix-server](https://hub.docker.com/r/varsy/zabbix-server/) with it.

There are following environment variables you need to set:
* `SERVER` - address of your zabbix server.
* `METADATA` - metadata to use for autoregistration.
* `HOST` - hostname of the agent.

For example:
```
/usr/bin/docker run --rm -e SERVER=zabbix.example.com \
-e METADATA=instance-example-prod -e HOST=instance-example-prod-`hostname` \
varsy/zabbix-agent
```
