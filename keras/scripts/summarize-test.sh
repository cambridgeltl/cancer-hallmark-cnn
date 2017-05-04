#!/bin/bash

if [ "$#" -lt 1 ]; then
    echo "Usage $0 LOGFILE [LOGFILE [...]]" >&2
    exit 1
fi

METRICS="f auc"

for m in $METRICS; do
    echo; echo "--- $m ---"
    for l in $(seq 9) a; do
	echo -n label-$l$'\t'
	echo "$(ls "$@" | xargs egrep -l 'datadir.*label-'$l \
	    | xargs egrep "best devel epoch\b.*\blabel-$l-test:" \
	    | perl -pe 's/.*\blabel-'"$l"'-test:.* '"$m"': (\S+)\%.*/$1/' \
	    | tr '\n' '\t' | perl -pe 's/\t?$//')"
    done \
	| while read l; do
	avg=$(echo "$l" \
	    | perl -pe 's/^\S+\s+//' \
	    | tr '\t' '\n' \
	    | awk '{ t+=$1; n++ } END { print t/n }' 2>/dev/null)
	echo "$l"$'\t'"AVG"$'\t'"$avg"
    done \
	| perl -pe '
	    if(/AVG\s+(\S+)/) { $t+=$1; $n++ }
	    END { $a=$t/$n; print "OVERALL AVG '"$f $m"'\t$a\t($t/$n)\n" }'
done
