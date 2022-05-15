pipeline {
    agent {
        dockerfile true
    }

    environment {
        registry = 'duongbm/fastapi-test'
        registryCredential = 'dockerhub'
    }

    stages {
        stage('Cloning Repository') {
            steps {
                checkout scm
            }
        }

        stage ('Build') {
           steps {
               sh 'python3 --version'
           } 
            // steps {
            //     script {
            //         app = docker.build registry + ":$BUILD_NUMBER"
            //     }
            // }
        }

        // stage ('Push') {
        //     steps {
        //         script {
        //             docker.withRegistry('', registryCredential) {
        //                 app.push()
        //             }
        //         }
        //     }
        // }
    }
}