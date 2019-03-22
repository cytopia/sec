#!/usr/bin/env bash

print_usage() {
	echo "$0 <file-ips> <file-dns>"
	echo
	echo "Tries to UDP-based reverse dns lookup every IP address against every DNS server"
	echo "via the host command."
	echo
	echo "<file-ips>       Path to file which contains IP addresses of targets to reverse lookup."
	echo "                 One IP address per line."
	echo "<file-dns>       Path to file which contains IP addresses of DNS servers to use for lookup."
	echo "                 One IP address per line."
}

get_ptr() {
	local target="${1}"
	local dns_server="${2}"

	# temporary
	local PTR=
	local addr=
	local name=

	if PTR="$( host -R 1 -W 1 -t PTR "${target}" "${dns_server}" )"; then
		if PTR="$( echo "${PTR}" | grep 'in-addr.arpa' )"; then
			addr="$( echo "${PTR}" | sed 's/in-addr.*$//g' | tac -s. | xargs | sed 's/\.$//g' )"
			name="$( echo "${PTR}" | awk '{print $NF}' | sed 's/\.$//g' )"
			echo "Host: ${target} DNS: ${dns_server} PTR: ${addr} ${name}"
			return 0
		fi
	fi
	echo "Host: ${target} DNS: ${dns_server}"
}

if [ "${#}" -ne "2" ]; then
	>&2 echo "Error, requires exactly two parameters"
	print_usage
	exit 1
fi
#if [ ! -f "${1}" ]; then
#       >&2 echo "Error, ${1} is not a file"
#       print_usage
#       exit 1
#fi
if [ ! -f "${2}" ]; then
	>&2 echo "Error, ${2} is not a file"
	print_usage
	exit 1
fi

for target in $( cat "${1}" ); do
	for dns in $( cat "${2}" ); do
		get_ptr "${target}" "${dns}" &
	done
done

# Wait for all background tasks to finish
wait
