pipeline {
    agent any

    environment {
        registry = 'gcr.io/jenkins-fastapi'
        registryCredential = 'gcr:ce-gcr'
    }

    stages {
        stage('Cloning Repository') {
            steps {
                checkout scm
            }
        }

        stage ('Build') {
            steps {
                script {
                    app = docker.build registry + ":$BUILD_NUMBER"
                }
            }
        }

        stage ('Push') {
            steps {
                script {
                    docker.withRegistry('https://gcr.io', registryCredential) {
                        app.push()
                    }
                }
            }
        }
    }
}