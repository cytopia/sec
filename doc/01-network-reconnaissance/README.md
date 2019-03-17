# Network scans

### Host discovery (ping + syn)
Fast, but not accurate, see:
https://security.stackexchange.com/questions/36198/how-to-find-live-hosts-on-my-network#36200
```bash
# Older nmap versions
nmap -sP 192.168.0.0/24
nmap -sP 192.168.0.1-254

# Newer nmap versions
nmap -sn 192.168.0.0/24
nmap -sn 192.168.0.1-254

# With grep-able output
nmap -sn 192.168.0.1-254 -oG
```

### Host discovery (via portscan)
```bash
# Older nmap versions
nmap -P0 192.168.0.0/24
nmap -P0 192.168.0.1-254

# Newer nmap versions
nmap -Pn 192.168.0.0/24
nmap -Pn 192.168.0.1-254

# With grep-able output
nmap -Pn 192.168.0.1-254 -oG file.txt
```
