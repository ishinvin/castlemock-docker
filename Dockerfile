FROM tomcat:9.0.76-jdk21-openjdk
LABEL maintainer="ishinvin26@gmail.com"

# Change directory to Tomcat webapps folder and download the latest Castle Mock war file
RUN cd /usr/local/tomcat/webapps && curl -o castlemock.war -fSL https://github.com/castlemock/castlemock/releases/download/v1.65/castlemock.war

COPY entrypoint.sh /usr/local/tomcat

RUN mkdir -p /usr/local/tomcat/projects/rest
RUN mkdir -p /usr/local/tomcat/projects/soap

# Expose HTTP port 8080
EXPOSE 8080

CMD [ "sh", "entrypoint.sh" ]
