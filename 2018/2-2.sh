#!/bin/bash
prev=()
for line in `cat 2.in`; do
	for i in "${!prev[@]}"; do
		if [[ "$(cmp -l <(echo "$line") <(echo "${prev[$i]}") | wc -l)" == 1 ]]; then
			index="`cmp -bl <(echo "$line") <(echo "${prev[$i]}") | awk '{print $1}'`"
			echo "$line" | cut --complement -c "$index" 
			found=1
			break;
		fi
	done
	if [[ "$found" == 1 ]]; then
		break;
	fi
	prev+=("$line")
done
