# Wordlists

## Generate wordlists
```bash
# Keywords from website
cewl www.megacorpone.com -m 6 -w /root/megacorp-cewl.txt
```

## Add mutations
```bash
# Add rule
vi /etc/john/john.conf
```
```
# Add two numbers to the end of each password
$[0-9]$[0-9]
```
```bash
john --wordlist=megacorp-cewl.txt --rules --stdout > mutated.txt
```
