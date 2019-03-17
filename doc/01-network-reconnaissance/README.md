# Network Reconnaissance

## Goal

Have a detailed matrix about your network as shown by the following table:

| IP address   | Network DNS name  | Netbios name | Avahi name |
|--------------|-------------------|--------------|------------|
| 192.168.0.1  | john.domain.local | JOHN         | john.local |

## Host discovery

### Host discovery (icmp + syn)
Fast, but not accurate, see:
https://security.stackexchange.com/questions/36198/how-to-find-live-hosts-on-my-network#36200
```bash
# With grep-able output
nmap -sn 192.168.0.1-254 -oG probe-icmp.txt
```

### Host discovery (portscan)
Very slow
```bash
# With grep-able output
nmap -Pn 192.168.0.1-254 -oG probe-ports.txt
```

### Host discovery (smb)
```bash
# quick, but not very reliable
nbtscan 192.168.0.1-254 > probe-smb.txt

# slow but finds more results
for i in `seq 1 254`; do nbtscan -s : 192.168.0.$i >> probe-smb.txt ; done
```

### Host discovery (avahi)
```bash
# requires avahi-daemon to run locally
for i in `seq 1 254`; do avahi-resolve -v -a 192.168.0.$i >> probe-avahi.txt; done
```

### Merge available hosts
In the final step we merge all IP's reported as up.
```bash
# Combine all found hosts into a single file separated by newlines
{
    grep ^Host probe-icmp.txt | cut -d' ' -f2;
	grep ^Host probe-ports.txt | cut -d' ' -f2;
	grep -Eo '^[^:]+' probe-smb.txt;
	grep -Eo '^[.0-9]+[^\s]' probe-avahi.txt;
} | sort -uV > hosts-up.txt
```


## DNS discovery

### DNS discovery (UDP)
```bash
# Store grep-able dns server list
nmap -sU -p53 -sV -P0 192.168.0.1-254 -oG probe-dns-udp.txt

# Create one IP per line file
grep ^Host probe-dns-udp.txt | cut -d' ' -f2 | sort -uV > hosts-dns.txt
```

### DNS discovery (reverse DNS)
The bundled script from this repository ([dns-reverse-lookup.sh](../../bin/dns-reverse-lookup.sh)) is used to ask each found DNS server for a reverse DNS record for each IP address (duplicates may occur).
```bash
dns-reverse-lookup.sh hosts-up.txt hosts-dns.txt hosts-reverse-dns.txt
```
