pipeline {
    agent any

    environment {
        image = 'ce-cbl-dev-cloudapi/jenkins-fastapi'
        registryCredential = 'gcr:ce-gcr'
        registry = 'https://gcr.io'
    }

    stages {
        stage('Show env') {
            steps {
                checkout scm
            }
        }

        stage ('Build') {
            steps {
                script {
                    app = docker.build image + ":$BUILD_NUMBER"
                }
            }
        }

        stage ('Push') {
            steps {
                script {
                    docker.withRegistry(registry, registryCredential) {
                        app.push()
                    }
                }
            }
        }

        stage ('Deploy') {
            steps {
                script {
                    sh '''
                        cat << _EOF_ | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
    name: fastapi-example
spec:
    containers:
    - name: fastapi-example
      image: ${image}:$BUILD_NUMBER
      ports:
      - containerPort: 8080
_EOF_'''
                }
            }
        }
    }
}