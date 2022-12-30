#!/usr/bin/env bash
set -x
#This is simply a working clone of the script originally created by Vladimir Zlatkin @ https://community.hortonworks.com/articles/16846/how-to-identify-what-is-consuming-space-in-hdfs.html

max_depth=$1
root_dir=$2
echo "Max deep : "$1
echo "Root dir : "$2
exit

largest_root_dirs=$(hdfs dfs -du -s "${root_dir}*" | sort -nr | perl -ane 'print "$F[1] "')

printf "%20s  %s\n" "bytes" "directory"
for ld in $largest_root_dirs; do
    printf "%'20.0f  %s\n" $(hdfs dfs -du -s $ld| cut -d' ' -f1) $ld
    all_dirs=$(hdfs dfs -ls -R $ld | egrep '^dr........' | perl -ane "scalar(split('/',\$_)) <= $max_depth && print \"\$F[7]\n\"" )


    for d in $all_dirs; do
        line=$(hdfs dfs -du -s $d)
        size=$(echo $line | cut -d' ' -f1)
        parent_dir=${d%/*}
        child=${d##*/}
        if [ -n "$parent_dir" ]; then
            leading_dirs=$(echo $parent_dir | perl -pe 's/./-/g; s/^.(.+)$/\|$1/')
            d=${leading_dirs}/$child
        fi
        printf "%'15.0f  %s\n" $size $d
    done
done
set +x