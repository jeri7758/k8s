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

        stage('Checking Docker is installed on server') {
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
            docker_version=$(docker images | grep "jerijs/kub_project" | wc -l)
            docker image tag jerijs/kub_project:latest jerijs/kub_project:V1.$docker_version
            echo $dockerhub_PSW | docker login -u $dockerhub_USR --password-stdin && docker push jerijs/kub_project:V1.$docker_version
            '''
            }
        }
    }
}

