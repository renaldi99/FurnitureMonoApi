pipeline {
    environment {
        DOCKER_IMAGE_NAME = "furniapp-image"
        DOCKER_IMAGE_TAG = "1.0"
        DOCKER_CONTAINER_NAME = "furniapp-container"
    }

    options {
        disableConcurrentBuilds()
        timeout(time: 10, unit: "MINUTES")
    }

    triggers {
        pollSCM('* * * * *')
    }

    agent {
        node {
            label "master"
        }
    }

    stages {
        stage("Prepare") {
            steps {
                echo "No action needed this stage"
            }
        }

        stage("Build Project") {
            steps {
                sh "dotnet restore"
                sh "dotnet build -c Release"
                sh "dotnet publish -c Release -o out"
            }
        }

        stage("Build Image") {
            steps {
                sh "docker build -t ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG} ."
            }
        }

        stage("Deploy") {
            steps {
                echo "Deploy to container"

                sh "docker run -d --name ${DOCKER_CONTAINER_NAME} -p 9002:80 ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}"
            }   
        }
    }

    post {
        always {
            echo "I always to run this pipeline"
        }
        success {
            echo "Pipeline is success"
        }
        failure {
            echo "Pipeline is failed"
        }
        cleanup {
            echo "Don't care success or error"
        }
    }
}