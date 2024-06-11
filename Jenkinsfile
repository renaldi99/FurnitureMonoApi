pipeline {
    agent {
        node {
            label "linux && java11 && dotnet6"
        }
    }
    stages {
        stage("Build") {
            steps {
                sh('dotnet build --configuration Release')
                echo("Start Build")
                sleep(10)
                echo("Finish Build")
            }
        }
        
        stage("Test") {
            steps {
                // sh("error")
                echo("Start Test")
                echo("Finish Test")
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