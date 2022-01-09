
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