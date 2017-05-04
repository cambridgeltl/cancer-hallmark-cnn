#!/bin/bash

if [ "$#" -lt 1 ]; then
    echo "Usage $0 LOGFILE [LOGFILE [...]]" >&2
    exit 1
fi

egrep -h '^[[:space:]]*"wordvecs":' "$@" | sort | uniq \
    | perl -pe 's/^\s*"wordvecs":\s*".*\/(.*?)"/$1/' \
    | while read w; do
    echo -e "\n\n---------- $w ----------\n"
    ls "$@" | xargs egrep -l '^[[:space:]]*"wordvecs":.*/'"$w" \
	| xargs ./summarize-devel.sh \
	| perl -pe 's/^(OVERALL AVG)/'$w' $1/' 
done
