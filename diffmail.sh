#!/bin/bash

if [ $# -ne 1 ]; then
	echo "Usage: <command> <mail address>"
	exit 1
fi

if ! [[ $1 =~  ^[a-zA-Z0-9_.\-]+\@[a-z0-9.\-]+$ ]];then
	echo "Check MailAddress"
	exit 1
fi

cd ~/sandbox/dnshijack-simple


mail=$1

datestr=$( date "+%Y%m%d%H" )
diff_log="./result/diff_"$datestr".log"
w_diff_log="./result/w_diff_"$datestr".log"

if [ ! -e $diff_log ]; then
	echo "diff file does not exist."
	exit 1
fi

if [ ! -e $w_diff_log ]; then
	echo "w_diff file does not exist."
	exit 1
fi

if [ -s $diff_log -o -s $w_diff_log ]; then
	cat $diff_log $w_diff_log | mail -s "[NG] DNS Hijack "$datestr $mail
else
	echo "OK" | mail -s "[OK] DNS Hijack "$datestr $mail
fi

exit 0
