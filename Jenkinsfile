pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "tejavardhan0987/devops-app"
    }

    stages {

        stage('Clone Repo') {
            steps {
                git 'https://github.com/Tejavardhan999/devops-jenkins-project.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'cd app && npm install'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE .'
            }
        }

        stage('Login to DockerHub') {
            steps {
                withCredentials([string(credentialsId: 'docker-pass', variable: 'PASS')]) {
                    sh 'echo $PASS | docker login -u tejavardhan0987 --password-stdin'
                }
            }
        }

        stage('Push Image') {
            steps {
                sh 'docker push $DOCKER_IMAGE'
            }
        }

        stage('Deploy to EC2') {
            steps {
                sh '''
                ssh -o StrictHostKeyChecking=no ubuntu@<EC2-IP> '
                docker pull tejavardhan0987/devops-app:latest &&
                docker stop app || true &&
                docker rm app || true &&
                docker run -d -p 3000:3000 --name app yourdockerhub/devops-app:latest
                '
                '''
            }
        }
    }
}