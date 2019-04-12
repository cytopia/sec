# URLs


## Enumerate URL's

#### Dirb
https://tools.kali.org/web-applications/dirb
```bash
# Find common URLs with a delay of 50ms between requests
dirb http://<ip|host>/ -z 50 -o urls.txt
```
