How to share the Internet on themote machine:

```
➜  ~ docker run --name squid  -d -p 3128:3128 -v `pwd`/squid.conf:/etc/squid/squid.conf datadog/squid   
➜  ~ ssh -R 3128:127.0.0.1:3128 root@rhost
root@rhost's password: 
[root@rhost ~]# export  https_proxy=http://127.0.0.1:3128 http_proxy=http://127.0.0.1:3128
[root@rhost ~]# curl http://ifconfig.me
184.124.122.52
```