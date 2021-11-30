pipeline {
   agent any 
   stages{
     stage("run frontedn")
       steps{
         echo 'executing yarn ..'
         nodejs('node-17.1.0'){
             sh 'yarn install'
             sh 'npm config ls'
         }
       }
    }
     stage("run backend")
       steps{
         echo 'executing graddle'
         sh './gradle'       
         }
       }
   }
}
