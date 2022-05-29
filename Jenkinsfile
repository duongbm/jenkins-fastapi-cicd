pipeline {
    agent any



    stages {

        stage("showing") {
            steps {
                echo "${env.image}";
                echo "${env.credential}"
            }
        }

        stage('Cloning repo') {
            steps {
                checkout scm
            }
        }

        stage ('Build') {
            steps {
                script {
                    def tag = "${env.key}-${env.GIT_COMMIT.substring(0,7)}"
                    app = docker.build("${env.image}:${tag}")
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
                    def tag = "${env.key}-${env.GIT_COMMIT.substring(0,7)}"
                    def image_id =  "${env.image}:${tag}"
                    sh "~/.local/bin/ansible-playbook  example.yml --extra-vars \"image=${image_id}\""
                }
            }
        }
    }
}