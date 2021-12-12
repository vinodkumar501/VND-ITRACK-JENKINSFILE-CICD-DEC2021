FROM tomcat:8
# Take the war and copy to webapps of tomcat
COPY target/*.jar /usr/local/tomcat/webapps/
//COPY /var/lib/jenkins/workspace/declarative pipeline/target/*.jar /usr/local/tomcat/webapps
//COPY /var/lib/jenkins/workspace/declarative pipeline/target/*.jar --> path where your .jar placed ---> you get an o/p from jenkins
