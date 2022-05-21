pipeline {
    agent any

    environment {
        image = 'ce-cbl-dev-cloudapi/jenkins-fastapi'
        registryCredential = 'gcr:ce-gcr'
        registry = 'https://asia.gcr.io'
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
        port: 80
_EOF_'''
                }
            }
        }

        // stage ('Update manifest') {
        //     environment {
        //         manifest = 'deployments/dev/deployment.yaml'
        //     }
        //     steps {
        //         script {
        //             catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
        //                 withCredentials([usernamePassword(credentialsId: 'github', passwordVariable: 'GIT_PASSWORD', usernameVariable: 'GIT_USERNAME')]) {
        //                     sh "git config user.email $email"
        //                     sh "git config user.name $GIT_USERNAME"

        //                     sh "sed -i 's/image:.*/image:ce-cbl-dev-cloudapi\\/jenkins-fastapi:$BUILD_NUMBER/' $manifest"
        //                     sh "cat $manifest"
        //                     sh "git add $manifest"
        //                     sh "git commit -m 'Jenkins change manifest'"
        //                     sh "git push https://${GIT_USERNAME}:${GIT_PASSWORD}@github.com/${GIT_USERNAME}/jenkins-fastapi-cicd.git HEAD:master"
        //                 }
        //             }
        //         }
        //     }
        // }
    }
}