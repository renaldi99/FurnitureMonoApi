pipeline {
    environment {
        DOCKER_IMAGE_NAME = "furniapp-image"
        DOCKER_IMAGE_TAG = "1.0"
        DOCKER_CONTAINER_NAME = "furniapp-container"
        REGISTRY = "185.199.52.89:8082"
        REPOSITORY = "docker-repo"
        CREDENTIALS_ID = "nexus"
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

        stage("Push Docker Image to Nexus") {
            steps {
                script {
                    docker.withRegistry("http://${REGISTRY}/repository/${REPOSITORY}", CREDENTIALS_ID) {
                        docker.image("${DOCKER_IMAGE_NAME}:latest").push('latest')
                    }
                }
            }
        }

        stage("Pull Docker Image") {
            steps {
                script {
                    docker.withRegistry("http://${REGISTRY}/repository/${REPOSITORY}", CREDENTIALS_ID) {
                        def image = docker.image("${DOCKER_IMAGE_NAME}:latest")
                        image.pull()
                        // image.inside {
                        //     // Replace 'your-command-here' with commands you want to run inside the container
                        //     sh 'your-command-here'
                        // }   
                    }
                }
            }
        }

        stage("Deploy") {
            steps {
                echo "Deploy to container"
                sh "docker run -d --name ${DOCKER_CONTAINER_NAME} -p 9002:80 ${DOCKER_IMAGE_NAME}:latest"
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