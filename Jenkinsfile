pipeline {
    agent any
    stages {
        stage('Build Docker image')
        {
            when { changeset "Dockerfile" }
            steps {
                echo 'Build Docker image...'
                sh "docker build --squash --compress --rm -t attina/${GIT_BRANCH}:latest ."
                sh "docker push attina/${GIT_BRANCH}:latest"
            }
        }
        stage('Build SDK') {
            when { changeset "sn335x/*" }
            steps {
                echo 'Build ${GIT_BRANCH} SDK'
                sh "docker pull attina/${GIT_BRANCH}:latest"
                sh "docker run -d -it --rm --name '${GIT_BRANCH}-${BUILD_NUMBER}' attina/${GIT_BRANCH}:latest"
                sh "docker cp sn335x '${GIT_BRANCH}-${BUILD_NUMBER}':/home/xtools/"
                sh "docker exec '${GIT_BRANCH}-${BUILD_NUMBER}' make sdk"
                sh "docker cp '${GIT_BRANCH}-${BUILD_NUMBER}':/home/xtools/buildroot/output/images ./"
                sh "tar zcf images.tar.gz images"
                sh "docker stop '${GIT_BRANCH}-${BUILD_NUMBER}'"
            }
        }
    }
    post {
        success {
            archiveArtifacts artifacts: '*.tar.gz', fingerprint: true
        }
        cleanup {
            echo 'Cleanup ...'
            sh "docker image prune -f"
        }
    }
}
