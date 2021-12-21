api=yes

api-key=qwfrerfssqerf

webserver=yes
# IP Address of web server to listen on
webserver-address=0.0.0.0
# Port of web server to listen on
webserver-port=8081
# Web server access is only allowed from these subnets
webserver-allow-from=0.0.0.0/0,::/0
	  	

powerdns-postgresql

helm repo add halkeye https://halkeye.github.io/helm-charts/ 

helm install my-powerdnsadmin halkeye/powerdnsadmin --set db.host=powerdns-postgresql --set db.password=pdnspass  -n powerdns