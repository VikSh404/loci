```
ls  | gawk  --lint --dump-variables  -v vvv=1 ' BEGIN { print "begin arg:" vvv } {print $0} END {print "last arg: "$1 }'

```
```
 cat t | awk 'BEGIN { print } /192.168.1.[1-2]\s/ {print $2 "\t" $1 } '
```


```
'/a/{++cnt} END {print "Count = ", cnt}'
```

```
cat t | awk '/192\.168\.1\./ {++cnt} END {print cnt} '
```


```
cat t | awk 'length($0) < 23'
```

```
cat t | awk -v FS=. 'BEGIN { print } /192.168.1.[1-2]\s/ {print $2 "\t" $1 } '
```

```
echo -e "One Two\nOne Two Three\nOne Two Three Four" | awk 'NF > 2'
```

```
➜  ~ cat t  
1) 192.168.1.1 fail 20
2) 192.168.1.2 accept 0
3) 192.168.1.3 accept 0
4) 192.168.1.4 accept 0
5) 192.168.1.5 accept 0
6) 192.168.1.4 fail 4
7) 192.168.1.1 fail 2
8) 192.168.1.7 accept 0
9) 192.168.1.1 accept 0
10) 192.168.1.2 accept 0
➜  ~ cat t | awk ' /[Ff]ail/ { if (array[$2] == 0 ) array[$2]=1; else array[$2]=array[$2]+1 }  END { for (key in array) {print key" = " array[key]} } '
192.168.1.1 = 2
192.168.1.4 = 1
```