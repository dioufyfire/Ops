## APIx
curl -u admin:Sonatel@221 -sS -G "https://hdp_adm1.orange-sonatel.com:8443/api/v1/clusters/bigdata/configurations/service_config_versions?service_name=HDFS&service_config_version=1" \
| jq -r '.items[].configurations[].properties["fs.defaultFS"] | select(. != null)'