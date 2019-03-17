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
