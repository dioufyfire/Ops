/usr/hdp/current/kafka-broker/bin/kafka-console-consumer.sh --bootstrap-server mespkafkaprd1.orange-sonatel.com:6667 mespkafkaprd3.orange-sonatel.com:6667 mespkafkaprd2.orange-sonatel.com:6667 --topic devfms_notifs   -consumer-property security.protocol=SASL_PLAINTEXT --property print.timestamp=true

/usr/hdp/current/kafka-broker/bin/kafka-topics.sh --list --zookeeper mespmasterprd1.orange-sonatel.com:2181

/usr/hdp/current/kafka-broker/bin/kafka-topics.sh --list --bootstrap-server mespkafkaprd1.orange-sonatel.com:6667 mespkafkaprd3.orange-sonatel.com:6667 mespkafkaprd2.orange-sonatel.com:6667


/usr/hdp/current/kafka-broker/bin/kafka-log-dirs.sh \
    --bootstrap-server mespkafkaprd1.orange-sonatel.com:6667 mespkafkaprd3.orange-sonatel.com:6667 mespkafkaprd2.orange-sonatel.com:6667 \
    --topic-list 'fms_notifs' \
    --describe \
  | grep '^{' \
  | jq '[ ..|.size? | numbers ] | add'

  usr/hdp/current/kafka-broker/bin/kafka-run-class.sh kafka.tools.JmxTool  --object-name kafka.server:type=BrokerTopicMetrics,name=MessagesInPerSec
  export JMX_PORT=${JMX_PORT:-6667}

  /usr/hdp/current/kafka-broker/bin/kafka-run-class.sh kafka.tools.GetOffsetShell  --broker-list mespkafkaprd3.orange-sonatel.com:6667 mespkafkaprd2.orange-sonatel.com:6667 --topic fms_notifs   | awk -F  ":" '{sum += $3} END {print "Result: "sum}'

  /usr/hdp/current/kafka-broker/bin/kafka-console-consumer.sh  --from-beginning  --bootstrap-server mespkafkaprd1.orange-sonatel.com:6667  --property print.value=false --property print.partition  --topic fms_notifs -consumer-property security.protocol=SASL_PLAINTEXT | tail -n 10|grep "Processed a total of" 

  /usr/hdp/current/kafka-broker/bin/kafka-console-consumer.sh --bootstrap-server mespkafkaprd1.orange-sonatel.com:6667 --topic fms_notifs --from-beginning  -consumer-property security.protocol=SASL_PLAINTEXT

  export KAFKA_OPTS="-Djava.security.auth.login.config=/usr/hdp/current/kafka-broker/config/kafka_client_jaas.conf"

  usr/hdp/current/kafka-broker/bin/kafka-log-dirs.sh --describe --bootstrap-server mespkafkaprd1.orange-sonatel.com:6667 --topic-list

  bin/kafka-consumer-groups.sh --bootstrap-server localhost:9092 --group gr1 --reset-offsets --topic training --execute
  --to-datetime '2022-12-27T00:00:00.000' --topic training --execute

  kafka-topics.sh --bootstrap-server localhost:9092 --alter --topic training --partitions 3

  kafka-reassign-partitions.sh --bootstrap-server localhost:9092 --reassignment-json-file reassign.json --execute

{"version":1,
"partitions":[
    {"topic":"training","partition":0,"replicas":[0,1,2]},
    {"topic":"training","partition":1,"replicas":[0,1,2]},
    {"topic":"training","partition":2,"replicas":[0,1,2]}
]}

bin/kafka-producer-perf-test.sh --topic training --throughput 100000 --record-size 102400 --num-records 3000000 --print-metrics --producer-props bootstrap.servers=localhost:9092


sh kafka-configs.sh --alter --entity-name training --add-config retention.ms=10000 --bootstrap-server localhost:9092

sh kafka-configs.sh --describe --entity-name training --entity-type topics --bootstrap-server localhost:9092

https://docs.confluent.io/platform/current/kafka/authorization.html#configuration-options-for-customizing-tls-ssl-user-name


node exporter


OM-HISTORIQUE -> 8 PARTITION / 4 MICRO
OM-HISTORIQUE-DIQTRI -> 16 PART / 8 MICRO

kafka-consumer-groups.sh --bootstrap-server 10.137.20.165:9092 --describe --group om_hist_distri_1

sh kafka-consumer-groups.sh --bootstrap-server 10.137.20.165:9092 --topic om-historique --reset-offsets --to-latest --group om_hist_1 --execute