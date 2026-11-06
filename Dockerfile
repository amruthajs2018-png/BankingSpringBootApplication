FROM eclipse-temurin:11-jdk
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} app.jar
EXPOSE 8989
ENTRYPOINT ["java","-jar","/app.jar"]

