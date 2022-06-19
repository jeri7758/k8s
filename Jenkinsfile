pipeline {
    agent any

    parameters {
        string(name: 'SERVER_IP', defaultValue: '34.93.4.5', description: 'Provide IP Address.')
    }

    environment {
        dockerhub=credentials('dockerhub')
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

        stage ('Building Docker image') {
            steps {
            sh 'pwd'
            sh '''
            "./docker_deploy.sh"
            '''
            }
        }

        stage ('Pushing to Docker hub') {
            steps {
            sh '''
            ssh -o StrictHostKeychecking=no jeri@34.93.4.5 'docker login -u $dockerhub_USR -p $dockerhub_PSW && docker push jerijs/kub_project:latest'
            '''
            }
        }
    }
}

