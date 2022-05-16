pipeline {
    agent any

    environment {
        registry = '$env.PROJECT/jenkins-fastapi'
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
                    docker.withRegistry(env.REGISTRY, registryCredential) {
                        app.push()
                    }
                }
            }
        }

        stage ('Update manifest') {
            steps {
                script {
                    catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                        withCredentials([usernamePassword(credentialsId: 'github', passwordVariable: 'GIT_PASSWORD', usernameVariable: 'GIT_USERNAME')]) {
                            sh "git config user.email ${env.GIT_EMAIL}"
                            sh "git config user.name $GIT_USERNAME"

                            sh "sed -i 's/image:.*/image:hello-world/' dev/deployment.yaml"
                            sh "cat dev/deployent.yaml"
                            sh "git add dev/deployment.yaml"
                            sh "git commit -m 'Jenkins change manifest'"
                            sh "git push https://${GIT_USERNAME}:${GIT_PASSWORD}@github.com/${GIT_USERNAME}/jenkins-fastapi-cicd.git HEAD:main"
                        }
                    }
                }
            }
        }
    }
}