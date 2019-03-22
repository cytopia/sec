# Network Reconnaissance

## Goal

Have a detailed matrix about your network as shown by the following table:

| IP address   | Network DNS name  | Netbios name | Avahi name |
|--------------|-------------------|--------------|------------|
| 10.11.1.1    | john.domain.local | JOHN         | john.local |

## Host discovery

### Host discovery (icmp + syn)
Fast, but not accurate, see:
https://security.stackexchange.com/questions/36198/how-to-find-live-hosts-on-my-network#36200
```bash
# With grep-able output
nmap -sn 10.11.1.1-254 -n -oG probe-up-icmp.txt
```

### Host discovery (portscan)
Very slow (1-2 hours)
```bash
# With grep-able output
nmap -Pn 10.11.1.1-254 -n -oG probe-up-ports.txt
```

### Host discovery (netbios)
```bash
# quick, but not very reliable
nbtscan 10.11.1.1-254 > probe-up-netbios.txt

# slow but finds more results
for i in `seq 1 254`; do nbtscan -s : 10.11.1.$i >> probe-up-netbios.txt; done

# same as above damn parallel and damn fast
for i in `seq 1 254`; do (nbtscan -s : 10.11.1.$i >> probe-up-netbios.txt &); done;
```

### Host discovery (avahi)
```bash
# requires avahi-daemon to run locally
for i in `seq 1 254`; do avahi-resolve -v -a 10.11.1.$i >> probe-up-avahi.txt; done

# same as above damn parallel and damn fast
for i in `seq 1 254`; do (avahi-resolve -v -a 10.11.1.$i >> probe-up-avahi.txt &); done;
```

### Merge discovered hosts
In the final step we merge all IP's reported as up.
```bash
# Combine all found hosts into a single file separated by newlines
{
    grep ^Host probe-up-icmp.txt | cut -d' ' -f2;
    grep ^Host probe-up-ports.txt | cut -d' ' -f2;
    grep -Eo '^[^:]+' probe-up-netbios.txt;
    grep -Eo '^[.0-9]+' probe-up-avahi.txt;
} | sort -uV > hosts-all-up.txt
```


## DNS discovery

### DNS discovery (udp)
```bash
# Retrieve list of IP's that have UDP 53 open (potential DNS server)
nmap -sU -n -p53 --open 10.11.1.1-254 -oG - \
  | grep ^Host \
  | cut -d' ' -f2 | sort -uV > hosts-dns-up.txt
```

### DNS discovery (reverse dns)
The bundled script from this repository ([dns-reverse-lookup.sh](../../bin/dns-reverse-lookup.sh)) is used to ask each found DNS server for a reverse DNS record for each IP address (duplicates may occur).
```bash
# Check for reverse DNS against all IP ranges
dns-reverse-lookup.sh \
    <(for i in `seq 1 254`;do echo 10.11.1.$i;done) \
    hosts-dns-up.txt > probe-dns-reverse.txt

# Create list of IP/DNS entries
grep PTR probe-dns-reverse.txt | cut -d' ' -f6,7 | sort -uV > hosts-all-dns.txt
```
