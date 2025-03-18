pipeline {
    agent any
    stages {
        stage('Start') {
            steps {
                echo 'Lab_2: started by GitHub'
            }
        }
        stage('Image build') {
            steps {
                script {
                    def IMAGE_NAME = "vasylsavka/prikm"
                    def BUILD_TAG = sh(script: "date +%Y%m%d%H%M%S", returnStdout: true).trim()
                    
                    sh "docker build -t ${IMAGE_NAME}:latest ."
                    sh "docker tag ${IMAGE_NAME}:latest ${IMAGE_NAME}:${BUILD_NUMBER}"
                    sh "docker tag ${IMAGE_NAME}:latest ${IMAGE_NAME}:${BUILD_TAG}"
                }
            }
        }
        stage('Push to registry') {
            steps {
                script {
                    def IMAGE_NAME = "vasylsavka/prikm"
                    def BUILD_TAG = sh(script: "date +%Y%m%d%H%M%S", returnStdout: true).trim()

                    withDockerRegistry([credentialsId: "dockerHub_token", url: "https://index.docker.io/v1/"]) {
                        sh "docker push ${IMAGE_NAME}:latest"
                        sh "docker push ${IMAGE_NAME}:${BUILD_NUMBER}"
                        sh "docker push ${IMAGE_NAME}:${BUILD_TAG}"
                    }
                }
            }
        }
        stage('Deploy image') {
            steps {
                sh "docker run -d -p 80:80 vasylsavka/prikm"
            }
        }
    }
}
