#!/bin/bash
dub=0
tri=0
for line in `cat 2.in`; do
	declare -A word
	hastwo=0
	hasthr=0
	for c in `echo "$line" | fold -w 1`; do
		word[$c]="$((word[$c]+1))"
	done
	for k in "${!word[@]}"; do
		if [[ ${word[$k]} == 2 ]]; then 
			hastwo=1
		fi
		if [[ ${word[$k]} == 3 ]]; then
			hasthr=1
		fi
	done
	if [[ $hastwo == 1 ]]; then
		dub="$((dub+1))"
	fi
	if [[ $hasthr == 1 ]]; then
		tri="$((tri+1))"
	fi
	unset word
done
echo "sum: ""$((dub*tri))"
