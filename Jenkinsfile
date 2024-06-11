pipeline {
    agent {
        node {
            label "linux && java11 && dotnet6"
        }
    }
    stages {
        stage('Branch') {
            echo "Created by ${env.SERVER_NAME}"
            if (env.BRANCH_NAME == 'master') {
                echo 'this project master'
            } else  {
                echo 'this project other branch'
            }
        }

        stage("Build") {
            steps {
                script {
                    // code groovy
                    for(int i = 0; i < 5; i++) {
                        echo("display ${i}")
                    }
                }

                // sh('dotnet build --configuration Release')
                echo("Start Build")
                sleep(10)
                echo("Finish Build")
            }
        }
        
        stage("Test") {
            steps {
                script {
                    def data = ["row_id": "001", "job_name": "furnimonoapi"]
                    writeJSON file: 'data.json', json: data
                }
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