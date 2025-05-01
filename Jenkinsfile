pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'nginx/custom:latest'
        PORT = '80'  // залишаємо порт 80
    }

    stages {
        stage('Start') {
            steps {
                echo 'Lab_1: nginx/custom'
            }
        }

        stage('Build nginx/custom') {
            steps {
                script {
                    // Створення Docker образу
                    echo 'Building Docker image...'
                    sh 'docker build -t nginx/custom:latest .'
                }
            }
        }

        stage('Test nginx/custom') {
            steps {
                echo 'Pass'
            }
        }

        stage('Deploy nginx/custom') {
            steps {
                script {
                    // Перевірка, чи порт 80 вже зайнятий
                    def portInUse = sh(script: "lsof -i :${PORT}", returnStatus: true)
                    if (portInUse != 0) {
                        echo "Port ${PORT} is in use. Stopping the existing container..."
                        sh 'docker stop $(docker ps -q --filter "ancestor=nginx/custom") || true'  // Зупиняємо контейнер, якщо він працює
                        sh 'docker rm $(docker ps -a -q --filter "ancestor=nginx/custom") || true'  // Видаляємо контейнер
                    }

                    // Запуск нового контейнера на порту 80
                    echo "Starting container on port ${PORT}..."
                    sh "docker run -d -p ${PORT}:${PORT} nginx/custom:latest"
                }
            }
        }
    }
}
