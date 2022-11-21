## TICKET

kinit -kt /etc/security/keytabs/ambari-infra-solr.service.keytab infra-solr/mespmasterprd2.orange-sonatel.com@BIGDATA 

kadmin.local -q 'addprinc -pw sonatel221 diop028920@BIGDATADEV' && kadmin.local -q 'xst -norandkey -k diop028920.keytab diop028920"@BIGDATADEV'

## SERVICES

service krb5kdc start
