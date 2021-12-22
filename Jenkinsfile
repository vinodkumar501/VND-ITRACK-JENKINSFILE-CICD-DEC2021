pipeline {
    agent any
    tools {
      maven 'mvn-3.8.4'
    }
    stages {
        stage (checkout) {
            steps {
                git credentialsId: 'git-cred', url: 'https://github.com/vinodkumar501/VND-hello-world-java-pom.xml.git'
		//checkout([$class: 'GitSCM', branches: [[name: 'refs/heads/master']], extensions: [], userRemoteConfigs: [[credentialsId: 'git-cred', url: 'https://github.com/vinodkumar501/VND-ITRACK-JENKINSFILE-CICD-DEC2021.git']]])
            }
        }
        stage (build) {
            steps {
                sh "mvn clean install"       //sh "mvn clean install -f mywebapp/prox.xml"   If pom.xml not in root folder
            }
        }
        stage (sonarqube_analysis) {
           steps {
              withSonarQubeEnv(credentialsId: 'sonarqube-cred', installationName: 'sonarqube-9.2') {            // You can override the credential to be used
			  sh 'mvn sonar:sonar'           //sh "mvn sonar:sonar -f mywebapp/prox.xml"   If pom.xml not in root folder
               //sh 'mvn org.sonarsource.scanner.maven:sonar-maven-plugin:3.7.0.1746:sonar'
              }
        } 

        //stage (nexus upload) {
           //steps {
              //nexusArtifactUploader artifacts: [[artifactId: 'maven-project', classifier: '', file: //'server/target/server.jar', type: 'pom']], credentialsId: 'nexus-cred', groupId: 'com.example.maven-project', //nexusUrl: '3.92.207.138:8081', nexusVersion: 'nexus3', protocol: 'http', repository: 'mvn-snapshot', version: //'1.0-SNAPSHOT'		
              //}
        //} 
		
        //stage (deploy_to_tomcat) {
           //steps {
              //deploy adapters: [tomcat8(path: '', url: 'http://54.82.235.95:8080/')], contextPath: null, war: '**/*.jar'	
              //}
        //}
    }    
  }
}
