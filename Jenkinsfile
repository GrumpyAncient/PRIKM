properties([
    [$class: 'Office365ConnectorJobProperty',
     webhooks: [[
         name: 'Teams-O365',
         url: 'https://lpnu.webhook.office.com/webhookb2/687e750c-bcee-4590-941e-c594a6d020c9@7631cd62-5187-4e15-8b8e-ef653e366e7a/IncomingWebhook/0f62f9720b8047398e1d80d0a66cb305/ce7527d8-657b-4c4b-a503-21037b76bdf3/V2V6HRLMo5jxqd2JPpdyiC0eH4E3PB0f1ok3UhcEhUjJ81',
         startNotification: false,
         notifySuccess: true,
         notifyAborted: false,
         notifyNotBuilt: false,
         notifyUnstable: true,
         notifyFailure: true,
         notifyBackToNormal: true,
         notifyRepeatedFailure: false,
         timeout: 30000
     ]]
    ]
])

node {
    def DOCKER_IMAGE = 'nginx/custom:latest'
    def PORT = '80'

    stage('Start') {
        echo 'Lab_1: nginx/custom'
    }

    stage('Build nginx/custom') {
        echo 'Building Docker image...'
        sh "docker build -t ${DOCKER_IMAGE} ."
    }

    stage('Test nginx/custom') {
        echo 'Pass'
    }

    stage('Deploy nginx/custom') {
        def portInUse = sh(script: "lsof -i :${PORT}", returnStatus: true)
        if (portInUse != 0) {
            echo "Port ${PORT} is in use. Stopping the existing container..."
            sh 'docker stop $(docker ps -q --filter "ancestor=nginx/custom") || true'
            sh 'docker rm $(docker ps -a -q --filter "ancestor=nginx/custom") || true'
        }

        echo "Starting container on port ${PORT}..."
        sh "docker run -d -p ${PORT}:${PORT} ${DOCKER_IMAGE}"
    }
}
