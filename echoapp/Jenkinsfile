pipeline {
    agent any

    stages {
        stage('Build the docker image') {
            steps {
                echo 'Building the docker image'
                sh './jenkins_scripts/build_image.sh' //This script will determine the branch, create teh right tag - and build the image with docker. 
            }
        }
        stage('Test') {
            steps {
                echo 'No Testing for echo application. But I know that generally tests exist... :) '
            }
        }
        stage('Deploy to GCR') {
            steps {
                echo 'Deploying to GCR'

                withCredentials([[$class: 'FileBinding', credentialsId: 'Google-GCR-auth', variable: 'GOOGLE_APPLICATION_CREDENTIALS']]) {
                    sh 'echo "${GOOGLE_APPLICATION_CREDENTIALS}"' // returns ****
                    sh 'gcloud auth activate-service-account --key-file $GOOGLE_APPLICATION_CREDENTIALS'
                    sh 'gcloud alpha auth configure-docker'
                    sh './jenkins_scripts/deploy.sh'
                }
                echo 'The image has been pushed to GCR. '
            }
        }
    }
}