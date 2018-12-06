#!/bin/bash
declare -A grid
declare -A claims
declare -A candidates
while read -r line; do
	r=0
	c=0
	id=`echo "$line" | awk '{print $1}'`
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
while read -r line; do
	r=0
	c=0
	id=`echo "$line" | awk '{print $1}'`
	candidates[$id]=1
	x=`echo "$line" | tr ',' ' ' | awk '{print $3}'`
	y=`echo "$line" | tr -d ':' | tr ',' ' ' | awk '{print $4}'`
	dx=`echo "$line" | tr 'x' ' ' | awk '{print $4}'`
	dy=`echo "$line" | tr 'x' ' ' | awk '{print $5}'`
	for i in `seq 0 "$((dx-1))"`; do
		for j in `seq 0 "$((dy-1))"`; do
			r="$((i+x))"
			c="$((j+y))"
			if [[ ${grid[$r,$c]} -ne 1 ]]; then
				unset candidates["$id"]
			fi
		done
	done
done < 3.in
for i in "${!candidates[@]}"; do
	echo "$i"
done
