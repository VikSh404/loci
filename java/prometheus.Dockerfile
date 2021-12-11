FROM maven:3.8.4-openjdk-8

LABEL com.example.loci="true"
LABEL version="1.0"
LABEL description="Loci project"

VOLUME /app
WORKDIR /app
RUN mvn archetype:generate -DarchetypeGroupId=org.apache.maven.archetypes -DgroupId=com.redstack  -DartifactId=memoryTool
WORKDIR /app/memoryTool

ADD App.java src/main/java/com/redstack/App.java
ADD config.yaml config.yaml
ADD jmx_prometheus_javaagent-0.16.1.jar jmx_prometheus_javaagent-0.16.1.jar
RUN sed -i '/[<]plugins[>]/a   <plugin>\n  <groupId>org.codehaus.mojo</groupId>\n  <artifactId>exec-maven-plugin</artifactId>\n  <configuration>\n  <executable>java</executable>\n  <arguments>\n  <argument>-Xms512m</argument>\n  <argument>-Xmx512m</argument>\n  <argument>-XX:NewRatio=3</argument>\n  <argument>-XX:+PrintGCTimeStamps</argument>\n  <argument>-XX:+PrintGCDetails</argument>\n  <argument>-Xloggc:gc.log</argument>\n  <argument>-classpath</argument>\n  <classpath/>\n  <argument>com.redstack.App</argument>\n  </arguments>\n  </configuration>\n  </plugin>' pom.xml
RUN mvn package
RUN apt update -y && apt install vim curl -y
EXPOSE 9999 9998 8080

#java  -classpath memoryTool-1.0-SNAPSHOT.jar com.redstack.App
# ENTRYPOINT ["mvn"]
# CMD ["package exec:exec"]

ENTRYPOINT ["/bin/bash", "-c"]
CMD  ["java -javaagent:jmx_prometheus_javaagent-0.16.1.jar=8080:config.yaml -Dcom.sun.management.jmxremote.port=9999 -Dcom.sun.management.jmxremote.rmi.port=9999 -Dcom.sun.management.jmxremote.local.only=false -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -classpath target/memoryTool-1.0-SNAPSHOT.jar com.redstack.App"]

#java -javaagent:/app/memoryTool/jmx_prometheus_javaagent-0.16.1.jar=8080:config.yaml -Dc-Djava.rmi.server.hostname=192.168.49.44 -Dcom.sun.management.jmxremote.port=9999 -Dcom.sun.management.jmxremote.rmi.port=9998 -Dcom.sun.management.jmxremote.local.only=false -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -classpath target/memoryTool-1.0-SNAPSHOT.jar com.redstack.App