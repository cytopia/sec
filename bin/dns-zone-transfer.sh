#!/usr/bin/env bash
#
# List nameservers of a domain and check if their corresponding
# NS servers allow zone transfer

if [ -z "${1}" ]; then
	>&2 echo "Usage: ${0} <domain>"
	>&2 echo
	>&2 echo "Tries to replicate DNS data for given domain by its found DNS server."
	exit 1
fi


DOMAIN="${1}"

for ns in $(host -t ns ${DOMAIN} | cut -d' ' -f4); do
	echo "# ------------------------------------------------------------"
	echo "# Name server: ${ns}"
	echo "# ------------------------------------------------------------"
	host -l ${DOMAIN} $ns || echo "Not transferable"
	echo
done
