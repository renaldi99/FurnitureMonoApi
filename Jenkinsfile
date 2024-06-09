pipeline {
    agent {
        node {
            label "linux && java11"
        }
    }
    stages {
        stage("Build") {
            steps {
                echo("Build with pipeline")
                sleep(10)
                echo("Finish build pipeline")
            }
        }
        
        stage("Test") {
            steps {
                echo("Test with pipeline")
            }
        }

        stage("Deploy") {
            steps {
                echo("Deploy with pipeline")
                script {
                    if(fileExists('Dockerfile')) {
                        echo "Dockerfile is found"
                    }
                }
                echo("Deploy success pipeline")
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