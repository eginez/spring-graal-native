#FROM graal-dev:latest as graal-dev
#COPY target/native-image /artifacts
#WORKDIR /artifacts
#RUN /root/src/graal-workspace2/graal/vm/latest_graalvm/graalvm-60d3f42926-java8-20.2.0-dev/bin/native-image \
#   --static \
#   --verbose \
#   -H:Name=commandlinerunner \
#   -Dspring.native.remove-xml-support=true \
#   -Dspring.native.remove-spel-support=true \
#   -Dspring.native.remove-jmx-support=true \
#   -cp BOOT-INF/classes:BOOT-INF/lib/spring-context-indexer-5.2.7.RELEASE.jar:BOOT-INF/lib/spring-beans-5.2.7.RELEASE.jar:BOOT-INF/lib/spring-jcl-5.2.7.RELEASE.jar:BOOT-INF/lib/snakeyaml-1.26.jar:BOOT-INF/lib/spring-core-5.2.7.RELEASE.jar:BOOT-INF/lib/spring-graalvm-native-0.8.0-SNAPSHOT.jar:BOOT-INF/lib/spring-boot-2.3.1.RELEASE.jar:BOOT-INF/lib/spring-boot-starter-2.3.1.RELEASE.jar:BOOT-INF/lib/spring-aop-5.2.7.RELEASE.jar:BOOT-INF/lib/jakarta.annotation-api-1.3.5.jar:BOOT-INF/lib/spring-boot-autoconfigure-2.3.1.RELEASE.jar:BOOT-INF/lib/spring-expression-5.2.7.RELEASE.jar:BOOT-INF/lib/spring-context-5.2.7.RELEASE.jar \
#   com.example.commandlinerunner.CommandlinerunnerApplication

FROM gcr.io/distroless/base
COPY target/commandlinerunner .
CMD ["/commandlinerunner"]