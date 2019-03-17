#!/bin/sh

print_usage() {
	echo "$0 <file-ips> <file-dns> <file-output>"
	echo
	echo "Tries to UDP-based reverse dns lookup every IP address against every DNS server"
	echo "via the host command."
	echo
	echo "<file-ips>       Path to file which contains IP addresses of targets to reverse lookup."
	echo "                 One IP address per line."
	echo "<file-dns>       Path to file which contains IP addresses of DNS servers to use for lookup."
	echo "                 One IP address per line."
	echo "<file-output>    Location to store the results"
}

if [ "${#}" -ne "3" ]; then
	print_usage
	exit 1
fi
if [ ! -f "${1}" ]; then
	print_usage
	exit 1
fi
if [ ! -f "${2}" ]; then
	print_usage
	exit 1
fi

for target in $( cat "${1}" ); do
	for dns in $( cat "${2}" ); do
		echo "\$ host -R 1 -W 1 -t PTR ${target} ${dns}"
		echo "\$ host -R 1 -W 1 -t PTR ${target} ${dns}" >> "${3}"
		if PTR="$( host -R 1 -W 1 -t PTR "${target}" "${dns}" | grep 'in-addr.arpa' )"; then
			addr="$( echo "${PTR}" | sed 's/in-addr.*$//g' | tac -s. | xargs | sed 's/\.$//g' )"
			name="$( echo "${PTR}" | awk '{print $NF}' | sed 's/\.$//g' )"
			echo "${addr} ${name}"
			echo "${addr} ${name}" >> "${3}"
		fi
	done
done
