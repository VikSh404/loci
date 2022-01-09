# HA postgres
AA + backups


# How to create a new backup?
```bash
barman switch-wal --force --archive db-01
barman backup db-01

```

# How to recovery from barman's backup?
Delete all Patroni's data on both databases:
```bash
systemctl stop patroni && ETCDCTL_API=3 /usr/local/bin/etcdctl del "" --from-key=true && rm -rf /var/lib/pgsql/11/data/*
```

Recovery you postgres data on one of them:
```bash
barman show-backup db-01 latest
barman recover --target-time "2022-01-09 16:48:44.270691+00:00" --remote-ssh-command "ssh postgres@db-01" db-01 20220109T164842 /var/lib/pgsql/11/data
```

Before start patroni service we need to run postgres from backup:  
```bash
/usr/pgsql-11/bin/pg_ctl -D /var/lib/pgsql/11/data start
```
Then we have to run patroni with this command:
```
/usr/local/bin/patroni /etc/patroni/patroni.yaml
```
Then we need to start the another patroni node as service and when second node gets a full replica data we can stop first patroni service and restart them as a service.




# P.S. tips
```
ETCDCTL_API=2 etcdctl cluster-health
etcdctl member list -w table
```

```
etcdctl --write-out=table --endpoints="10.0.0.103:2380,10.0.0.104:2380,10.0.0.101:2380" endpoint status
```

```
etcdctl --endpoints="10.0.0.103:2380,10.0.0.104:2380,10.0.0.101:2380" endpoint health
```

```
etcdctl --write-out=table --endpoints="10.0.0.103:2380,10.0.0.104:2380,10.0.0.101:2380" endpoint status
```


```
/usr/local/bin/patronictl  -c /etc/patroni/patroni.yaml list
/usr/local/bin/patronictl  -c /etc/patroni/patroni.yaml reinit postgres1
```