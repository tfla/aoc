#!/bin/bash
declare -A grid
while read -r line; do
	r=0
	c=0
	x=`echo "$line" | tr ',' ' ' | awk '{print $3}'`
	y=`echo "$line" | tr -d ':' | tr ',' ' ' | awk '{print $4}'`
	dx=`echo "$line" | tr 'x' ' ' | awk '{print $4}'`
	dy=`echo "$line" | tr 'x' ' ' | awk '{print $5}'`
	for i in `seq 0 "$((dx-1))"`; do
		for j in `seq 0 "$((dy-1))"`; do
			r="$((i+x))"
			c="$((j+y))"
			grid[$r,$c]=$((${grid[$r,$c]}+1))
		done
	done
done < 3.in
n=0
for i in "${!grid[@]}"; do
	if [[ "${grid[$i]}" -gt 1 ]]; then
		n=$((n+1))
	fi
done
echo "$n"
