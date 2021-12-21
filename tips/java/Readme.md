1) 192.168.49.44 - your docker host IP in Dockerfile
2) jvisualvm - run
3) install plugin VisualGC
```bash
docker build -t test .
docker run  -ti --rm -p9999:9999  -p9998:9998  test
```


Prometheus run java:
```bash


java -javaagent:jmx_prometheus_javaagent-0.16.1.jar=8080:config.yaml -Dcom.sun.management.jmxremote.port=9999 -Dcom.sun.management.jmxremote.rmi.port=9999 -Dcom.sun.management.jmxremote.local.only=false -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -classpath target/memoryTool-1.0-SNAPSHOT.jar com.redstack.App
```

Build for prometheus
```
➜  java git:(master) ✗ docker build -t test -f ./prometheus.Dockerfile .              
[+] Building 0.1s (15/15) FINISHED                                                                                                        
 => [internal] load build definition from prometheus.Dockerfile                                                                      0.0s
 => => transferring dockerfile: 48B                                                                                                  0.0s
 => [internal] load .dockerignore                                                                                                    0.0s
 => => transferring context: 2B                                                                                                      0.0s
 => [internal] load metadata for docker.io/library/maven:3.8.4-openjdk-8                                                             0.0s
 => [ 1/10] FROM docker.io/library/maven:3.8.4-openjdk-8                                                                             0.0s
 => [internal] load build context                                                                                                    0.0s
 => => transferring context: 547B                                                                                                    0.0s
 => CACHED [ 2/10] WORKDIR /app                                                                                                      0.0s
 => CACHED [ 3/10] RUN mvn archetype:generate -DarchetypeGroupId=org.apache.maven.archetypes -DgroupId=com.redstack  -DartifactId=m  0.0s
 => CACHED [ 4/10] WORKDIR /app/memoryTool                                                                                           0.0s
 => CACHED [ 5/10] ADD App.java src/main/java/com/redstack/App.java                                                                  0.0s
 => CACHED [ 6/10] ADD config.yaml config.yaml                                                                                       0.0s
 => CACHED [ 7/10] ADD jmx_prometheus_javaagent-0.16.1.jar jmx_prometheus_javaagent-0.16.1.jar                                       0.0s
 => CACHED [ 8/10] RUN sed -i '/[<]plugins[>]/a   <plugin>\n  <groupId>org.codehaus.mojo</groupId>\n  <artifactId>exec-maven-plugin  0.0s
 => CACHED [ 9/10] RUN mvn package                                                                                                   0.0s
 => CACHED [10/10] RUN apt update -y && apt install vim curl -y                                                                      0.0s
 => exporting to image                                                                                                               0.0s
 => => exporting layers                                                                                                              0.0s
 => => writing image sha256:abbc68bfdf590a2ab55eeabdc86ba5714c1022fea1a6db18dad54e5c2df2c916                                         0.0s
 => => naming to docker.io/library/test                                                                                              0.0s

Use 'docker scan' to run Snyk tests against images to find vulnerabilities and learn how to fix them
➜  java git:(master) ✗ docker run  -ti --rm  -p9999:9999 -p9998:9998 -p8080:8080 test 
Welcome to Memory Tool!


I have 0 objects in use, about 0 MB.
What would you like me to do?
1. Create some objects
2. Remove some objects
0. Quit
```
Check
```bash
➜  ~ curl localhost:8080 | grep jvm_memory_pool_bytes_committed
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 10913  100 10913    0     0   133k      0 --:--:-- --:--:-- --:--:--  133k
# HELP jvm_memory_pool_bytes_committed Committed bytes of a given JVM memory pool.
# TYPE jvm_memory_pool_bytes_committed gauge
jvm_memory_pool_bytes_committed{pool="Code Cache",} 2555904.0
jvm_memory_pool_bytes_committed{pool="Metaspace",} 1.179648E7
jvm_memory_pool_bytes_committed{pool="Compressed Class Space",} 1572864.0
jvm_memory_pool_bytes_committed{pool="PS Eden Space",} 8912896.0
jvm_memory_pool_bytes_committed{pool="PS Survivor Space",} 1048576.0
jvm_memory_pool_bytes_committed{pool="PS Old Gen",} 2.2544384E7
➜  ~ 

```