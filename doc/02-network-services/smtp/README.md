# SMTP

## Verify user exists
```bash
nc -nv <ip> 25
220 redhat.acme.com ESMTP Sendmail 8.12.8/8.12.8; Fri, 27 Sep 2013
VRFY bob
250 2.1.5 <bob@redhat.acme.com>
VRFY idontexist
550 5.1.1 idontexist... User unknown
```
