pipeline {
    agent any

    parameters {
        string(name: 'SERVER_IP', defaultValue: '34.93.4.5', description: 'Provide IP Address.')
    }

    environment {
        dockerhub= credentials('dockerhub')
        CREDENTIALS_ID= 'kubernetes'
        PROJECT_ID= 'fifth-mechanism-345915'
        CLUSTER_NAME= 'cluster-1'
        LOCATION= 'us-central1-c'
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
            docker image tag jerijs/kub_project:latest jerijs/kub_project:${BUILD_ID}
            echo $dockerhub_PSW | docker login -u $dockerhub_USR --password-stdin && docker push jerijs/kub_project:${BUILD_ID}
            '''
            }
        }
        stage ('Starting Deployment') {
            steps {
            sh 'pwd'
            sh 'ls -ltr'
            sh "cd k8s && sed -i 's/tagname/$BUILD_ID/g' 'deployment.yaml'"
                step([$class: 'KubernetesEngineBuilder', projectId: PROJECT_ID, clustername: CLUSTER_NAME, location: LOCATION, manifestPattern: deployment.yaml, credentials: kubernetes, verifyDeployments: true ])
            echo "deployment completed......"
            }
        }
    }
}

