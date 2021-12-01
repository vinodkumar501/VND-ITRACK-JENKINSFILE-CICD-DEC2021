node {
    def nodeHome = tool name: 'node'//, type: 'jenkins.plugins.nodejs.tools.NodeJSInstallation'
    env.PATH = "${nodeHome}/bin:${env.PATH}"

    stage('check tools') {
        sh "node -v"
        sh "npm -v"
    }

    stage('checkout') {
        checkout scm
    }

    stage('npm install') {
        nodejs('node-17.1.0'){
        sh "npm init"
        sh "npm install yarn"
        }
      }

    stage('unit tests') {
        sh "npm test -- --watch=false"
    }

    stage('protractor tests') {
        sh "npm run e2e"
    }
  }  
