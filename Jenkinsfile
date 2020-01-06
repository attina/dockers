pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                echo 'Building...'
                sh 'docker build --squash --compress --rm -t attina/${GIT_BRANCH}:latest .'
            }
        }
        stage('Archive') {
            steps {
                echo 'Extracting x-tools from containner...'
                sh './extract-artifacts.sh'
                echo 'Push image to docker hub...'
                sh 'docker push attina/${GIT_BRANCH}:latest'
            }
        }
        stage('Push & Clean') {
            steps {
                echo 'Cleanup ...'
                sh 'docker image prune'
            }
        }
    }
    post {
        always {
            archiveArtifacts artifacts: '*.tar.gz', fingerprint: true
        }
    }
}
