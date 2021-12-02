//https://www.youtube.com/watch?v=L9Ite-1pEU8
//https://medium.com/@gustavo.guss/jenkins-starting-with-pipeline-doing-a-node-js-test-72c6057b67d4
//https://medium.com/appgambit/ci-cd-pipeline-for-a-nodejs-application-with-jenkins-fa3cc7fad13a
//https://www.blazemeter.com/blog/how-to-use-the-jenkins-scripted-pipeline

https://plugins.jenkins.io/nodejs/

Pipeline
The current supported DSL steps are:

nodejs (as buildwrapper)
tools
In a Declarative pipeline you can add any configured NodeJS tool to your job, and it will enhance
the PATH variable with the selected NodeJS installation folder, instead in scripted pipeline you have to do it manually.

---------------------------->Example of use tools in Jenkinsfile (Scripted Pipeline)<-----------------------------------

node {
    env.NODEJS_HOME = "${tool 'Node 6.x'}"
    // on linux / mac
    env.PATH="${env.NODEJS_HOME}/bin:${env.PATH}"
    // on windows
    env.PATH="${env.NODEJS_HOME};${env.PATH}"
    sh 'npm --version'
}
This example show the use of buildwrapper, where enhanced PATH will be available only inside the brace block


---------------------------->Example of use tools in Jenkinsfile (Declarative Pipeline)<-----------------------------------
Example of the use of buildwrapper Jenkinsfile (Declarative Pipeline)

pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                nodejs(nodeJSInstallationName: 'Node 6.x', configId: '<config-file-provider-id>') {
                    sh 'npm config ls'
                }
            }
        }
    }
}



------------------->Configure plugin via Groovy script<---------------------------
Either automatically upon Jenkins post-initialization or through Jenkins script console, example:

#!/usr/bin/env groovy
import hudson.tools.InstallSourceProperty
import jenkins.model.Jenkins
import jenkins.plugins.nodejs.tools.NodeJSInstallation
import jenkins.plugins.nodejs.tools.NodeJSInstaller
import static jenkins.plugins.nodejs.tools.NodeJSInstaller.DEFAULT_NPM_PACKAGES_REFRESH_HOURS

final versions = [
        'NodeJS 8.x': '8.16.1'
]

Jenkins.instance.getDescriptor(NodeJSInstallation).with {
    installations = versions.collect {
        new NodeJSInstallation(it.key, null, [
                new InstallSourceProperty([
                        new NodeJSInstaller(it.value, null, DEFAULT_NPM_PACKAGES_REFRESH_HOURS)
                ])
        ])
    }  as NodeJSInstallation[]
}
