# SNMP

* Port UDP/161

```bash
nmap -sU --open -p 161 10.11.1.1-254 -oG snmp.txt
```


Can give you various information such as:
- OS name/version
- running programs
- install software (e.g.: windows hotfixes)
- open ports (which port scan does not reveal due to firewall block)
- network interfaces / ip addresses (is a net behind it)
- open network connections
- user accounts

## Enumeration
```
snmpenum

# Enumerate the meat
snmp-check <ip>
```
