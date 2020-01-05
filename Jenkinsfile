pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                sh 'docker build --squash --compress --rm -t attina/${GIT_BRANCH}:latest .'
            }
        }
        stage('Push') {
            steps {
                echo 'docker push attina/${GIT_BRANCH}:latest'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}
