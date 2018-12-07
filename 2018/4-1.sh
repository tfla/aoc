declare -A slp
declare -A grid
guard=0
while read -r line; do
	if [[ `echo "$line" | grep '#'` ]]; then
		guard="$(echo "$line" | awk '{print $4}' | tr -d '#')"
	elif [[ `echo "$line" | grep 'asleep'` ]]; then
		s="$(echo "$line" | awk '{print $2}' | cut -c 4-5 | awk '{print "10#" $0}')"
	elif [[ `echo "$line" | grep 'wakes'` ]]; then
		w="$(echo "$line" | awk '{print $2}' | cut -c 4-5 | awk '{print "10#" $0}')"
		tmp="$(((w-s)%60))"
		slp[$guard]=$((${slp[$guard]}+tmp))
		for ((i=s;i<w;i++)); do
			m="$(((i)%60))"
			grid[$guard,$m]=$((${grid[$guard,$m]}+1))
		done
	fi
done < 4.in.sorted
max=0
id=0
for i in "${!slp[@]}"; do
	if [[ "${slp[$i]}" -gt "$max" ]]; then
		max="${slp[$i]}"
		id="$i"
	fi
done
max2=0
min=0
for i in "${!grid[@]}"; do
	if [[ "$(echo "$i" | tr ',' ' ' | awk '{print $1}')" -eq "$id" && "${grid[$i]}" -gt "$max2" ]]; then
		max2="${grid[$i]}"
		min="$(echo "$i" | tr ',' ' ' | awk '{print $2}')"
		echo "$min"": ""${grid[$i]}"
	fi
done
echo "guard ""$id"" slept a total of ""$max"" minutes and most often at minute ""$min"
echo "chksum: ""$((id*min))"
