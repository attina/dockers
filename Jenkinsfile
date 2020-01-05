pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                echo 'Building...'
                sh 'docker build --squash --compress --rm -t attina/${GIT_BRANCH}:latest .'
            }
        }
        stage('Extract') {
            steps {
                echo 'Extracting x-tools from containner...'
                sh './extract-artifacts.sh'
            }
        }
        stage('Push') {
            steps {
                echo 'Push image to docker hub...'
                sh 'docker push attina/${GIT_BRANCH}:latest'
            }
        }
    }
    post {
        always {
            archiveArtifacts artifacts: '*.tar.gz', fingerprint: true
        }
    }
}
