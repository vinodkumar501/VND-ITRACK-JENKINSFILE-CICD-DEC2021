//https://www.youtube.com/watch?v=L9Ite-1pEU8
pipeline {
   agent any 
   tools {
       gradle('gradle-7')     //gradle-7 is the name we mentioned in automatic gradle installation
   }
   stages{
      stage("run frontend"){     //stage any have to provide
       steps{
         echo 'executing yarn ..'
         nodejs('node-17.1.0'){    //node-17.1.0 is the name we mentioned in automatic node installation install nodejs plugin
         sh 'yarn install'     
         sh 'npm config ls'
         sh 'npm -version'
         sh 'node --version'
         sh 'yarn -version'
         }
       }
      }
      stage("run backend"){
       steps{
         echo 'executing graddle'
         sh 'gradle init'
         sh 'gradle -version'
         sh 'gradle clean build'
         //https://docs.gradle.org/current/userguide/jenkins.html
         //http://tutorials.jenkov.com/gradle/run-gradle.html//gradle commands
         }
      }
   }
}
 
