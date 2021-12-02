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


//echo 'running ${env.BUILD_NUMBER} and job ${env.JOB_NAME}'  -->print o/p -->running ${env.BUILD_NUMBER} and job ${env.JOB_NAME}
//Single quotes won't allow substitution. Try double quotes, escaping the dollar sign:
//https://stackoverflow.com/questions/60648171/unable-to-substitute-jenkins-build-number-variable-in-pipeline-script

