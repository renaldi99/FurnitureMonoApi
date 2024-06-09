pipeline {
    agent {
        node {
            label "linux && java11"
        }
    }
    stages {
        stage("Run") {
            steps {
                echo("Run with pipeline")
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