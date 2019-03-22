# SMB

### Get Netbios hostname by IP
```bash
nbtscan <ip>
```

### Check for SMB NULL sessions (no username)
```bash
rpcclient -U "" <ip>
rpcclient $> srvinfo          # Display OS version
rpcclient $> enumdomusers     # Display list of usernames
rpcclient $> getdompwinfo     # Display password policy
```

### Enumerate SMB server
```bash
# Tries to retrieve: users, groups, shares, policies and more
enum4linux -va <ip>
```

### Probe SMB users for given IP
```bash
nmap -p 139,445 --script smb-enum-users <ip>
```

### Check for SMB vulnerabilities
```bash
nmap -p 139,445 --script vuln --script-args=unsafe=1 <ip>
```

### Bruteforce
```bash
# -L path to file containing usernames (one per line)
# -P path to file containing passwords (one per line)
# -V verbose: show attempts
hydra -V -L smb-users.txt -P /usr/share/wordlists/dirb/small.txt 10.11.1.1 smb
```
