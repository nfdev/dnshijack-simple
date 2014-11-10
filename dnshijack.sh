#!/bin/bash

if [ $# -ne 1 ]; then
	echo "Usage: <command> <target_domain>"
	exit 1
fi

if ! [[ $1 =~  ^[a-zA-Z0-9_.\-]+$ ]];then
	echo "Check domain name"
	exit 1
fi

cd ~/sandbox/dnshijack-simple
domain=$1

fname="./data/"$domain"_"$( date "+%Y%m%d%H")
fname_p="./data/"$domain"_"$( date -d "1 hours ago" "+%Y%m%d%H")

nslookup -type=NS $domain > $fname

date "+%Y%m%d%H" >> ./diff.log 2>&1
diff $fname $fname_p >> ./diff.log 2>&1


