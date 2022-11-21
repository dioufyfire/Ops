## Log into ZK

zookeeper-client -server <zk server & port>

## Check what configurations are available

ls /infra-solr/configs

## Delete configurations related to ranger audits (including the ones you have created). For example:

rmr /infra-solr/configs/ranger_audits