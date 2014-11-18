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

datestr=$( date "+%Y%m%d%H" )
fname="./data/"$domain
w_fname="./data/w_"$domain
fname_p="./data/"$domain".old"
w_fname_p="./data/w_"$domain".old"

diff_log="./result/diff_"$datestr".log"
w_diff_log="./result/w_diff_"$datestr".log"

[ ! -e $fname ] && touch $fname
[ ! -e $w_fname ] && touch $w_fname

mv $fname $fname_p
mv $w_fname $w_fname_p
nslookup -type=NS $domain > $fname
whois $domain > $w_fname

diff <( grep "=" $fname | sort ) <( grep "=" $fname_p | sort ) >> $diff_log 2>&1
[ $? -gt 1 ] && echo "^^^^^      "$fname"     ^^^^^\n" >> $diff_log

diff <( grep -v "Last update of whois database:" $w_fname ) <( grep -v "Last update of whois database:" $w_fname_p ) >> $w_diff_log 2>&1
[ $? -gt 1 ] && echo "^^^^^      "$fname"     ^^^^^\n" >> $diff_log

