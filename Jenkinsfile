pipeline {
    agent any

    stages {
        stage("showing") {
            steps {
                echo "${dev}";
                echo "${env.GIT_COMMIT.substring(0,7)}"
            }
        }
    }


    stages {
        stage('Cloning repo') {
            steps {
                checkout scm
            }
        }

        stage ('Build') {
            steps {
                script {
                    app = docker.build("${env.image}:${env.tag}")
                }
            }
        }

        stage ('Push') {
            steps {
                script {
                    docker.withRegistry("${env.registry}", "${env.credential}") {
                        app.push()
                    }
                }
            }
        }

        stage ('Deploy') {
            steps {
                script {
                    def image_id =  "${env.image}:${env.tag}"
                    sh "ansible-playbook  example.yml --extra-vars \"image=${image_id}\""
                }
            }
        }
    }
}