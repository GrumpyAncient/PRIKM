pipeline {
    agent any
    triggers {
        cron('H H * * *') // щоденний запуск в довільний час
    }
    properties([
        parameters([
            string(name: 'GREETING', defaultValue: 'Hello', description: 'Привітання'),
            booleanParam(name: 'RUN_TESTS', defaultValue: true, description: 'Виконувати тести?')
        ]),
        office365ConnectorWebhooks(webhooks: [
            [
                name: 'Teams-ci-notifications',
                url: 'https://lpnu.webhook.office.com/webhookb2/687e750c-bcee-4590-941e-c594a6d020c9@7631cd62-5187-4e15-8b8e-ef653e366e7a/IncomingWebhook/0f62f9720b8047398e1d80d0a66cb305/ce7527d8-657b-4c4b-a503-21037b76bdf3/V2V6HRLMo5jxqd2JPpdyiC0eH4E3PB0f1ok3UhcEhUjJ81',
                startNotification: false,
                notifySuccess: true,
                notifyUnstable: true,
                notifyFailure: true,
                notifyBackToNormal: true,
                timeout: 30000
            ]
        ])
    ])
    stages {
        stage('Build') {
            steps {
                echo 'Building project...'
                // Тут можуть бути команди збірки
            }
        }
        stage('Test') {
            when { expression { params.RUN_TESTS } }
            steps {
                echo "Running tests with greeting: ${params.GREETING}"
                // Додайте ваші команди тестування
            }
        }
    }
    post {
        always {
            publishHTML(target: [
                reportDir: 'reports',
                reportFiles: 'index.html',
                reportName: 'HTML Report'
            ])
        }
    }
}
