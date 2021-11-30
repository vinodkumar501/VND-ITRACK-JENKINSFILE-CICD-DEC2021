//https://www.youtube.com/watch?v=L9Ite-1pEU8
pipeline {
   agent any 
   //tools {
       //gradle('gradle-7')  
   //}
   stages{
      stage("run frontend"){
       steps{
         echo 'executing yarn ..'
         nodejs('node-17.1.0'){
             sh 'yarn install'
             sh 'npm config ls'
             sh 'npm -version'
             sh 'node --version'
             sh 'yarn -version'
            }
          }
        }
      }
      stage("run backend"){
       steps{
         echo 'executing graddle'
         gradle('gradle-7')  
          sh 'gradle init'
          sh 'gradle -version'
          sh 'gradle clean build'
         //https://docs.gradle.org/current/userguide/jenkins.html
         //http://tutorials.jenkov.com/gradle/run-gradle.html//gradle commands
         }
      }
   }
 
