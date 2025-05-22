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
                sh "docker build -t prikm:latest ."
                sh "docker tag prikm vasylsavka/prikm:latest"
                sh "docker tag prikm vasylsavka/prikm:$BUILD_NUMBER"
            }
        }
        stage('Test image') {
            steps {
                sh "docker images | grep prikm"
            }
        }
        stage('Push to registry') {
            steps {
                withDockerRegistry([ credentialsId: "dockerHub_token", url: "" ]) {
                    sh "docker push vasylsavka/prikm:latest"
                    sh "docker push vasylsavka/prikm:$BUILD_NUMBER"
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
