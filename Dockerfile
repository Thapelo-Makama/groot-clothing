FROM tomcat:10.1-jdk17-temurin

# Remove default webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the WAR as ROOT.war so it deploys at "/"
COPY GrootClothing.war /usr/local/tomcat/webapps/ROOT.war

# Tomcat listens on 8080 by default
EXPOSE 8080

# Run Tomcat
CMD ["catalina.sh", "run"]
