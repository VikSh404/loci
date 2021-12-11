```
➜  awk git:(master) ✗ cat t  | gawk  --lint --dump-variables  -v vvv=1 ' BEGIN { print "begin arg:" vvv } {print $0} END {print "last arg: "$1 }'
begin arg:1
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
gawk: cmd. line:1: (FILENAME=- FNR=10) warning: accessing fields from an END rule may not be portable
last arg: 10)
➜  awk git:(master) ✗ 

```
```
➜  awk git:(master)  cat t | gawk 'BEGIN { print } /192.168.1.[1-2]\s/ {print $2 "\t" $1 } '

192.168.1.1     1)
192.168.1.2     2)
192.168.1.1     7)
192.168.1.1     9)
192.168.1.2     10)
```


```
➜  awk git:(master) cat t | gawk '/fail/ {++cnt} END {print "Fails = ", cnt}'
Fails =  3
```

```
➜  awk git:(master) cat t | gawk '/192\.168\.1\./ {++cnt} END {print cnt} '
10
```


```
➜  awk git:(master) cat t | gawk 'length($0) < 23'
1) 192.168.1.1 fail 20
6) 192.168.1.4 fail 4
7) 192.168.1.1 fail 2
```

```
➜  awk git:(master) cat t | gawk -v FS=. 'BEGIN { print } /192.168.1.[1-2]\s/ {print $2 "\t" $1 } '

168     1) 192
168     2) 192
168     7) 192
168     9) 192
168     10) 192
```

```
➜  awk git:(master) echo -e "One Two\nOne Two Three\nOne Two Three Four" | awk 'NF > 2'
One Two Three
```

```
➜  awk git:(master) cat t | gawk ' /[Ff]ail/ { if (array[$2] == 0 ) array[$2]=1; else array[$2]=array[$2]+1 }  END { for (key in array) {print key" = " array[key]} } '
192.168.1.1 = 2
192.168.1.4 = 1
```