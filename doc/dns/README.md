# DNS

### Gather DNS server (UDP)
```bash
# Store grep-able dns server list
nmap -sU -p53 -sV -P0 192.168.0.1-254 -oG rec-probe-hosts-dns-udp.txt

# Create one IP per line file
grep ^Host rec-probe-hosts-dns-udp.txt | cut -d' ' -f2 | sort -uV > hosts-dns.txt
```
