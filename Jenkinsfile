pipeline {
    environment {
        AUTHOR = "RENALDI"
    }

    agent {
        node {
            label "master"
        }
    }

    stages {
        stage("Prepare") {
            steps {
                echo "Prepare for build project and deploy as a container"
            }
        }

        stage("Build") {
            steps {
                echo "Build this image"
            }
        }

        stage("Deploy") {
            steps {
                echo "Deploy to container"
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