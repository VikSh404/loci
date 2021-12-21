```
$ LIST=''; while read p; do IP=$(echo $p | egrep '[Ff]ail' | cut -f2 -d' '); if ! [[ $IP = '' ]] && ( [[ $LIST[@] == '' ]] || ! [[ $IP =~ "$(echo $LIST[@] | tr ' ' '|' )" ]] ) ; then LIST=($LIST[@] $IP) && eval "let VAR_${IP//./_}+=1" ; fi  ; done < t; set | egrep '^VAR_.*' | gsed 's/VAR_\(.*\)/\1/g; s/_/./g';  for i in $(set | egrep '^VAR_.*'); do unset ${i%%=*}; done
192.168.1.1=2
192.168.1.4=1
```


```
#always forgot about this:

$ a='hello:world'

$ b=${a%:*}
$ echo "$b"
hello

$ a='hello:world:of:tomorrow'

$ echo "${a%:*}"
hello:world:of

$ echo "${a%%:*}"
hello

$ echo "${a#*:}"
world:of:tomorrow

$ echo "${a##*:}"
tomorrow

$ IP=1.1.1.1
$ echo ${IP//./_}+
1_1_1_1
```