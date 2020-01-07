pipeline {
    agent any
    stages {
        stage('Prepare') {
            steps {
                echo 'Pull Docker image...'
                sh "docker pull attina/${GIT_BRANCH}:latest"
            }
        }
        stage('Build') {
            steps {
                echo 'Extract SDK and images'
                sh "docker run -d -it --name '${GIT_BRANCH}-${BUILD_NUMBER}' attina/${GIT_BRANCH}:latest"
                sh "docker exec '${GIT_BRANCH}-${BUILD_NUMBER}' make sdk"
                sh "docker cp '${GIT_BRANCH}-${BUILD_NUMBER}':/home/xtools/buildroot/output/images ./"
                sh "tar zcf images.tar.gz images"
            }
        }
        stage('Cleanup') {
            steps {
                echo 'Cleanup ...'
				sh "docker stop '${GIT_BRANCH}-${BUILD_NUMBER}'"
                sh "docker rm '${GIT_BRANCH}-${BUILD_NUMBER}'"
                sh "docker image prune -f"
            }
        }
    }
    post {
        always {
            archiveArtifacts artifacts: '*.tar.gz', fingerprint: true
        }
    }
}
