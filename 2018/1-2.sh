#!/bin/bash
fpush() { sed -e "\$a$2" -i~ $1; }
fshift() { local v n=$'\n';read -r v < <(
    sed -e $'1{w/dev/stdout\n;d}' -i~ "$1")
    printf ${2+-v} $2 "%s${n[${2+2}]}" "$v"
}

declare -A res
cur=0
while : ; do
	fshift 1.in tmp
	case "${tmp:0:1}" in
		"+")
			cur="$((cur+"${tmp:1}"))"
			if [[ ${res[$cur]+_} ]]; then
				break;
			else
				res[$cur]=1
			fi
			;;
		"-")
			cur="$((cur-"${tmp:1}"))"
			if [[ ${res[$cur]+_} ]]; then
				break;
			else
				res[$cur]=1
			fi
			;;
		*)
	esac
	fpush 1.in "$tmp"
done
echo "$cur"
echo "${#res[@]}"
