#!/bin/bash

if [ "$#" -lt 1 ]; then
    echo "Usage $0 LOGFILE [LOGFILE [...]]" >&2
    exit 1
fi

egrep -h '^[[:space:]]*"filter_sizes":' "$@" \
    | perl -pe 's/^\s*"filter_sizes":\s*\[\s*(.*?)\s*\],.*$/$1/' \
    | sort -n | uniq \
    | while read f; do
    echo -e "\n\n---------- $f ----------\n"
    ls "$@" | xargs egrep -l '^[[:space:]]*"filter_sizes":.*\[[[:space:]]*'"$f"'[[:space:]]*\]' \
	| xargs ./summarize-devel.sh \
	| perl -pe 's/^(OVERALL AVG)/'"$f"' $1/' 
done
