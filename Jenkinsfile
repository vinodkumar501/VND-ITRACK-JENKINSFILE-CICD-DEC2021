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
        nodejs('node'){
        //sh "npm init"
        echo "hi"
        //sh "npm install yarn"
        }
      }

    stage 'check environment'
    sh "node -v"
    sh "npm -v"
    sh "yarn -v"
	
    stage('checkout') {
        checkout scm
    }
	   
    def versionInfo = sh (
        script: '/opt/gradle/gradle-4.4.1/bin/gradle -q printVersion',
        returnStdout: true
        ).trim()
        echo "VersionInfo: ${versionInfo}"
        //set the current build to versionInfo plus build number.
        currentBuild.displayName = "${versionInfo}-${currentBuild.number}" ;

    def commitmessage = sh (
        script: 'git log origin/aperture_1.3.0 --numstat --since="1 month ago" -s --format=%b|while read i; do  sed "/^$/d"| sed "s/^/* /g"; done;',
        returnStdout: true
        )
 
    def Build_Gradle = {
	script {
	sh "npm update"
	sh "/opt/gradle/gradle-4.4.1/bin/gradle clean"
	sh "/opt/gradle/gradle-4.4.1/bin/gradle -Pprod build -x test"
	//if  (env.JOB_NAME == 'Dev1') {
		//sh "/opt/gradle/gradle-4.4.1/bin/gradle sonarqube -x test  -Dsonar.host.url=http://35.230.46.150:9000"
		//}
	sh "cp src/main/docker/Dockerfile build/libs/"
	sh "sudo chmod 666 /var/run/docker.sock"
	}
    }
    
 
    if (env.JOB_NAME == 'Dev1') {
          
    stage "Packaging"
   
	Build_Gradle()
        
	stage "Image packaging"
        sh "docker build -t us.gcr.io/itrack-1652018/itrack-dev1 build/libs/."

	stage "Push images"
	sh "gcloud docker -- push us.gcr.io/itrack-1652018/itrack-dev1"
    
    stage "Approve"
    mail to: 'vinod.chenna@gspann.com', subject: "Please approve Dev1 deployment for qa.aperture.gspann.com #${env.BUILD_NUMBER}", 
    body: """
Hi,

Please approve below feature for QA before release.

Please click to approve the before release in Dev1 : ${BUILD_URL}input/

        """
        input submitterParameter: 'userId', message: 'Ready?'
		
        stage "Deploy to itrack Dev1"
        sh "gcloud container clusters get-credentials itrack-dev --zone us-west1-a --project itrack-1652018"
        sh "kubectl delete deploy itrack-app || echo \"deployment not available\""
        sh "kubectl create -f src/main/docker/kubernetes/itrack-dev/deployment/itrack-app-dev-deployment.yaml"
    }
	
    if (env.JOB_NAME == 'Dev2') {
	stage "Packaging"
	Build_Gradle()

        stage "Image packaging"
        sh "docker build -t us.gcr.io/itrack-1652018/itrack-dev2 build/libs/."

	stage "Push images"
	sh "gcloud docker -- push us.gcr.io/itrack-1652018/itrack-dev2"
		
	stage "Deploy to itrack Dev2"    
        sh "gcloud container clusters get-credentials itrack-jenkins-cd --zone us-west1-a --project itrack-1652018"
        sh "kubectl delete deploy itrack-app"
        sh "kubectl create -f src/main/docker/kubernetes/itrack-dev/deployment/itrack-app-deployment.yaml"
       }
  
    if (env.JOB_NAME == 'QA') {
	stage "Packaging"
	Build_Gradle()

   	stage "Image packaging"
    	sh "docker build -t us.gcr.io/itrack-1652018/itrack-qa build/libs/."

	stage "Push images"
	sh "gcloud docker -- push us.gcr.io/itrack-1652018/itrack-qa"

        stage "Image Tagging"
        sh "docker tag us.gcr.io/itrack-1652018/itrack-qa:latest us.gcr.io/itrack-1652018/release-tag:${versionInfo}"
        sh "gcloud docker -- push us.gcr.io/itrack-1652018/release-tag:${versionInfo}"

        stage "Deploy to itrack QA"    
        sh "gcloud container clusters get-credentials itrack-qa --zone us-west1-a --project itrack-1652018"
        sh "kubectl delete deploy itrack-app || echo \"deployment not available\""
        sh "kubectl create -f src/main/docker/kubernetes/itrack-qa/deployment/itrack-app.yaml"
       }

     if (env.JOB_NAME == 'Production') {   
        stage "Approve"
        mail to: 'mmalik@gspann.com, ngrover@gspann.com', cc: 'krishna.garg@gspann.com,puneet.bansal@gspann.com', subject: "Please approve production deployment for aperture.gspann.com #${env.BUILD_NUMBER}", 
        body: """
Hi,

Please approve below feature for production release.

Sn.	Jira			Description

1	ITRACK-1536    MFA Notification and document download in Aperture


Please click to approve the release in production : ${BUILD_URL}input/

        """
        input submitterParameter: 'userId', message: 'Ready?'
	
        stage "Deploying tag for Production" 
	sh "yes |gcloud container images add-tag us.gcr.io/itrack-1652018/itrack-qa:latest us.gcr.io/itrack-1652018/itrack-production:latest"
		
        stage "Deploy to itrack Production" 
        sh "gcloud beta container clusters get-credentials prod-itrack --region us-west1 --project itrack-1652018"
        sh "kubectl delete deploy itrack-app-prod"
        sh "kubectl create -f src/main/docker/kubernetes/Itrack-production/deployment/itrack-app.yaml"
     }
     
     stage "Deployment done"
     echo "Welcome Aperture"

    // Success or failure, always send notifications
    notifyBuild(currentBuild.result)
  }

  //def notifyBuild(String buildStatus = 'STARTED') {
  // build status of null means successful
  //buildStatus =  buildStatus ?: 'SUCCESSFUL'

  def scmVars = checkout scm
  env.GIT_BRANCH = scmVars.GIT_BRANCH
  def colorName = 'RED'
  def colorCode = '#FF0000'
  def subject = "${buildStatus}: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'"
  def summary = "${subject} (${env.BUILD_URL}) (${env.GIT_BRANCH})" 
  def details = """  STARTED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'
    Check console output at ${env.BUILD_URL}
    Job Name : ${env.JOB_NAME}
    Build No: ${env.BUILD_NUMBER}
    Branch: ${env.GIT_BRANCH}"""

  // Override default values based on build status
  if (buildStatus == 'STARTED') {
    color = 'YELLOW'
    colorCode = '#FFFF00'
  } else if (buildStatus == 'SUCCESSFUL') {
    color = 'GREEN'
    colorCode = '#00FF00'
  } else {
    color = 'RED'
    colorCode = '#FF0000'
  }

  // Send notifications
  slackSend (color: colorCode, message: summary)
//  mail to: 'abhishek.maurya@gspann.com, krishna.garg@gspann.com, manoj.nautiyal@gspann.com', subject: subject, 
//  body: details
//}

