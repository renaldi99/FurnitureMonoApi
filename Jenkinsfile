pipeline {
    environment {
        AUTHOR = "Renaldi" // env variable
        APP = credentials("try_env_credential") // get credential by id from jenkins use this
    }

    options {
        disableConcurrentBuilds() // tidak bisa jalan / build paralel (bareng) note: awalnya bisa, jika pake ini sudah tidak bisa
        timeout(time: 10, unit: "MINUTES") // aborted / dibatalkan jika lewat

    }

    parameters {
        string(name: 'DEPLOY_ENV', defaultValue: 'staging', description: 'Deploy environtment')
    }

    triggers {
        // cron("* * * * *")
        pollSCM('* * * * *')
    }

    agent {
        node {
            label "linux && dotnet6"
        }
    }

    stages {

        stage("Parameter") {
            steps {
                echo "deploy env: ${params.DEPLOY_ENV}"
            }
        }

        stage("Prepare") {
            steps {
                echo("Author: ${AUTHOR}")
                echo("Username credential: ${APP_USR}")
                // echo("Password credential: ${APP_PSW}")
                sh('echo "Password credential: $APP_PSW" > "crendetial.txt"') // cara store credential ke file agar yang aman
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

                    if (env.BRANCH_NAME == 'master') {
                        echo "this branch ${env.BRANCH_NAME}"
                    } else  {
                        echo "this branch ${env.BRANCH_NAME}"
                    }

                    def props = readJSON file: 'dataqu.json'
                    assert props['domain-expansion'] == 'quantela'
                    echo("domain: ${props['domain-expansion']}")
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