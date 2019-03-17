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
		echo "\$ host -a -R 1 -W 1 ${target} ${dns}"
		echo "\$ host -a -R 1 -W 1 ${target} ${dns}" >> "${3}"
		host -a -R 1 -W 1 "${target}" "${dns}" >> "${3}"
	done
done
