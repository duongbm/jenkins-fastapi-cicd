pipeline {
    agent any

    environment {
        image = 'gcr.io/ce-cbl-dev-cloudapi/jenkins-fastapi'
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
                    tag = 'CE:${BUILD_NUMBER}'
                    app = docker.build("${env.image}:${tag}")
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
                    tag = 'CE:${BUILD_NUMBER}'
                    sh '''
                        cat << _EOF_ | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
    name: fastapi-example
spec:
    containers:
    - name: fastapi-example
      image: ${image}:${tag}
      ports:
      - containerPort: 8080
_EOF_'''
                }
            }
        }
    }
}