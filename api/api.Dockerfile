FROM java:8
FROM maven:alpine
WORKDIR /app
COPY . /app
RUN mvn -v
RUN mvn clean install -DskipTests
EXPOSE 8080
RUN pwd
RUN ls
ADD ./target/spring-boot-mysql-0.0.1-SNAPSHOT.jar /developments/
ENTRYPOINT ["java","-jar","/developments/spring-boot-mysql-0.0.1-SNAPSHOT.jar"]
