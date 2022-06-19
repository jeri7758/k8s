pipeline {
    agent any

    parameters {
        string(name: 'SERVER_IP', defaultValue: '34.93.4.5', description: 'Provide IP Address.')
    }

    options{
        skipStagesAfterUnstable()
    }

    stages {
        stage('source code fetch') {
            steps{
            git branch: 'main', changelog: false, poll: false, url: 'git@github.com:jeri7758/k8s.git'
            }
        }

        stage('Checking Docker is installed') {
            steps{
            sh 'docker --version'                       
            }
        }

        stage ('Building Docker image and pushing to Docker hub') {
            steps {
            sh 'ssh -o StrictHostKeychecking=no jeri@ docker_deploy.sh'
            }
        }  
    }
}

