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
                        docker.image("${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}").push("${DOCKER_IMAGE_TAG}")
                    }
                }
            }
            post {
                cleanup {
                    echo "clean image in local"
                    sh "docker rmi ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}"
                }
            }
        }

        stage("Pull Docker Image") {
            steps {
                script {
                    def imageExists = sh(script: "docker images -q ${REGISTRY}/${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}", returnStdout: true).trim()

                    if (imageExists) {
                        echo "Image already exists locally."
                    } else {
                        docker.withRegistry("http://${REGISTRY}/repository/${REPOSITORY}", CREDENTIALS_ID) {
                            echo "Pull Image from Nexus"
                            def image = docker.image("${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}")
                            image.pull()
                            // image.inside {
                            //     // Replace 'your-command-here' with commands you want to run inside the container
                            //     sh 'your-command-here'
                            // }   
                        }
                    }
                }
            }
        }

        stage("Deploy") {
            steps {
                script {
                    // Destroy container existing and deploy new container if exists
                    def containerRunning = sh(script: "docker ps -q -f name=${DOCKER_CONTAINER_NAME}", returnStdout: true).trim()

                    if (containerRunning) {
                        // Remove to deploy new
                        sh "docker container stop ${DOCKER_CONTAINER_NAME} || true"
                        sh "docker container rm ${DOCKER_CONTAINER_NAME} || true"
                    }

                    echo "Deploy to container"
                    sh '''
                    docker run -d --name ${DOCKER_CONTAINER_NAME} -p 9002:80 ${REGISTRY}/${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}
                    '''
                }
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