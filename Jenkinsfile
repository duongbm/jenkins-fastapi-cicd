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
                    echo "tag ${env.tag}"
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