#!/bin/sh

set -x

## LISTER LES DOSSIERS RACINES ET LEURS SIZE
hdfs dfs -ls / | grep "^d" |  tr -s " " | cut -d' ' -f8  > /tmp/hdfs_dir_root_size.txt 
date_epoch=$(date +"%Y-%m-%dT%T.%3NZ")

while IFS= read -r line; do
    path=$(echo ${line})
    size=$(hdfs dfs -du -s $path |  tr -s " " | cut -d' ' -f2 )
    size=$(($size+1))
    echo $size
    curl -k --user bigdata-ingest:6SM6DMYkJZspp5r -XPOST https://elastic.seetlu.orange-sonatel.com/bigdata-hdfs-metric/_doc -H  'Content-Type: application/json' -d '
        {"@timestamp": "'$date_epoch'",
         "dir_size": '$size',
         "dir_name": "'$line'",
         "is_subdir": 0,
         "ref_dir": "'$line'"
        }'
done < /tmp/hdfs_dir_root_size.txt 

## LISTER LES DOSSIERS RACINES ET LEURS SUBDIR ET LEUR SIZE
while IFS= read -r line_sub; do
    path=$(echo ${line_sub})
    hdfs dfs -ls $path | grep "^d" |  tr -s " " | cut -d' ' -f8  > /tmp/hdfs_dir_subdir_size.txt
    while IFS= read -r line_sub_on; do
        path_sub=$(echo ${line_sub_on})
        size=$(hdfs dfs -du -s $path_sub |  tr -s " " | cut -d' ' -f2 )
        size=$(($size+1))
        echo $size
        curl -k --user bigdata-ingest:6SM6DMYkJZspp5r -XPOST https://elastic.seetlu.orange-sonatel.com/bigdata-hdfs-metric/_doc -H  'Content-Type: application/json' -d '
            {"@timestamp": "'$date_epoch'",
            "dir_size": '$size',
            "dir_name": "'$path_sub'",
            "is_subdir": 1,
            "ref_dir": "'$line_sub'"
            }'
    done < /tmp/hdfs_dir_subdir_size.txt
done < /tmp/hdfs_dir_root_size.txt 

set +x

exit

### --> ALGO A SUIVRE

# RECUPERER LES DOSSIERS RACINES ET LEUR TAILLES EN TOTAL SUR LE CLUSTER
# CLASSER PAR ORDRE DECROISSANT DES TAILLES
# RELEVER LES TOP 5 
# PARCOURIR LES SOUS DOSSIERS DES TOP 5 ET RECUPERER LE NOM DES DOSSIERS  / TAILLES

## -> INFO A ENVOYER
# TIMESTAMP
# NOM_DOSSIER (/dossier/path)
# TAILLE (en byte)
# is_subdir (1 / 0)
# ref (nom_dossier_parent)