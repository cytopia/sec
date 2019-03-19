# SMB

### Get Netbios hostname by IP
```bash
nbtscan <ip>
```

### Probe SMB users for given IP
```bash
nmap -p 139,445 --script smb-enum-users <ip>
```

### Check for SMB vulnerabilities
```bash
nmap -p 139,445 --script vuln <ip>
```

### Bruteforce
```bash
# -L path to file containing usernames (one per line)
# -P path to file containing passwords (one per line)
# -V verbose: show attempts
hydra -V -L smb-users.txt -P /usr/share/wordlists/dirb/small.txt 192.168.0.1 smb
```
