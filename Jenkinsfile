pipeline{
  agent any
  stages{
    stage('check'){
	  steps{
	    sh 'printenv'            // first print env varialbles
	   }
	 }
    stage('build'){
	  steps{
	    echo "running ${env.BUILD_NUMBER} and job ${env.JOB_NAME}"
	   }
	 }
	}
}
