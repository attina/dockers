pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                echo 'Pull Docker image...'
                sh 'docker pull attina/${GIT_BRANCH}:latest'
            }
        }
        stage('Archive') {
            steps {
                echo 'Extract SDK and images'
                sh './extract-artifacts.sh'
            }
        }
        stage('Cleanup') {
            steps {
                echo 'Cleanup ...'
            }
        }
    }
    post {
        always {
            archiveArtifacts artifacts: '*.tar.gz', fingerprint: true
        }
    }
}
