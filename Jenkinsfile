pipeline {
    agent any

    environment {
        registry = 'gcr.io/jenkins-fastapi'
        registryCredential = credentials('ce-gcr')
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
                    docker.withRegistry('', registryCredential) {
                        app.push()
                    }
                }
            }
        }
    }
}