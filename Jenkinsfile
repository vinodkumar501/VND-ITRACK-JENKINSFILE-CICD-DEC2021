//node{
    //stage ('checkout git')
    //checkout scm      
    //The checkout step will checkout code from source control; scm is a special variable which instructs the checkout step to clone the specific
    //revision which triggered this Pipeline run
//}
pipeline{
  agent any
  stages{
    stage('build'){
	  steps{
	    sh 'printenv'
	   }
	 }
	}
}

//Setting environment variables
//Setting an environment variable within a Jenkins Pipeline is accomplished differently depending on whether Declarative or Scripted Pipeline is used.

//Declarative Pipeline supports an environment directive, whereas users of Scripted Pipeline must use the withEnv step.
