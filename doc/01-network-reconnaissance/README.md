# Network scans

### Host discovery (icmp + syn)
Fast, but not accurate, see:
https://security.stackexchange.com/questions/36198/how-to-find-live-hosts-on-my-network#36200
```bash
nmap -sn 192.168.0.0/24
nmap -sn 192.168.0.1-254

# With grep-able output
nmap -sn 192.168.0.1-254 -oG probe-icmp.txt
```

### Host discovery (via portscan)
Very slow
```bash
nmap -Pn 192.168.0.0/24
nmap -Pn 192.168.0.1-254

# With grep-able output
nmap -Pn 192.168.0.1-254 -oG probe-ports.txt
```

### Host discovery (via smb)
```bash
# quick and not very reliable
nbtscan 192.168.0.1-254

# slow but finds more results
for i in `seq 1 254`; do nbtscan -s : 192.168.0.$i; done

# slow but finds more results with save in file
for i in `seq 1 254`; do nbtscan -s : 192.168.0.$i >> probe-smb.txt ; done
```

### Host discovery (via avahi)
```bash
for i in `seq 1 254`; do avahi-resolve -v -a 192.168.0.$i >> probe-avahi.txt; done
```
