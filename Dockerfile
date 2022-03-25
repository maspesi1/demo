FROM  registry.access.redhat.com/ubi8/ubi:8.0

# command line options to pass to the JVM
ENV   JAVA_OPTIONS -Xmx512m


# Install the Java runtime, create a user for running the app, and set permissions
RUN   yum install -y --disableplugin=subscription-manager java-11-openjdk-headless && \
      yum clean all --disableplugin=subscription-manager -y && \
      useradd demoapp && \
      mkdir -p /opt/app-root/bin

COPY  ./target/demo-0.0.1-SNAPSHOT.jar /opt/app-root/bin/demo.jar

RUN   chown -R demoapp:demoapp /opt/app-root && \
      chmod -R 700 /opt/app-root

EXPOSE 8080

USER  demoapp

# Run the fat JAR
CMD   java $JAVA_OPTIONS -jar /opt/app-root/bin/demo.jar
