//node{
    //stage ('checkout git')
    //checkout scm      
    //The checkout step will checkout code from source control; scm is a special variable which instructs the checkout step to clone the specific
    //revision which triggered this Pipeline run
//}
pipeline{
  node any
  stages{
    stage('build'){
	  steps{
	    echo 'running ${BUILD_NUMBER} and job ${JOB_NAME}
	   }
	 }
	}
}
