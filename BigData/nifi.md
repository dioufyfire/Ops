42f36c99-162e-3bfe-b927-8561f15fddb3

bc1b24e6-017f-1000-ffff-ffffb03eaf91


curl -i -k -X PUT -H 'Content-Type: application/json' -d '{"id":"bc1b24e6-017f-1000-ffff-ffffb03eaf91","state":"RUNNING"}' https://mespnifiprd2.orange-sonatel.com:9091/nifi-api/flow/process-groups/bc1b24e6-017f-1000-ffff-ffffb03eaf91;

curl 'http://localhost:8080/nifi-api/processors/d03bbf8b-015d-1000-f7d6-2f949d44cb7f' -X PUT -H 'Content-Type: application/json' --data-binary '{"revision":{"clientId":"09dbb50e-015e-1000-787b-058ed0938d0e","version":1},"component":{"id":"d03bbf8b-015d-1000-f7d6-2f949d44cb7f","state":"STOPPED"}}'


curl  http://localhost:8080/nifi-api/controller/process-groups/root/processors/f511a6a1-015d-1000-970e-969eac1e6fc5'-X PUT -H 'Accept: application/json'-d @stop.json -vv



curl -k -X POST -d "username=sddesigner&password=SntDlkSdd@2020" -H "Content-Type: application/x-www-form-urlencoded" -d "username=sddesigner&password=SntDlkSdd@2020" https://mespnifiprd2.orange-sonatel.com:9091/nifi-api/access/token

-H "Authorization: Bearer $token"
system-diagnostics
curl -u sddesigner:SntDlkSdd@2020 -i -k -X  GET https://mespnifiprd2.orange-sonatel.com:9091/nifi-api/processors/bc1b24e6-017f-1000-ffff-ffffb03eaf91
hdfs dfs -ls hdfs://bigdata/apps/hbase/data