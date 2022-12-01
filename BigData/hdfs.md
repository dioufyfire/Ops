## Group & Users

hdfs groups userx -> groupe d'appartenance d'un utilisateur

## STORAGE
hdfs dfs -ls -S -h -> sort by size and Human readable

hdfs dfs -ls /spark2-history	|   tr -s " "	|	cut -d' ' -f6-8	| 	grep "^[0-9]"	|	awk 'BEGIN{ MIN=43200; LAST=60*MIN; "date +%s" | getline NOW } { cmd="date -d'\''"$1" "$2"'\'' +%s"; cmd | getline WHEN; DIFF=NOW-WHEN; if(DIFF > LAST){ print "Deleting: "$3; system("hdfs dfs -rm -r -skipTrash "$3) }}'