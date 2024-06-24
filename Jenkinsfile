pipeline {
    // bisa ditaruh spesifik stage
    environment {
        AUTHOR = "Renaldi" // env variable
        APP = credentials("try_env_credential") // get credential by id from jenkins use this
    }

    // bagian dari configure pipeline
    options {
        disableConcurrentBuilds() // tidak bisa jalan / build paralel (bareng) note: awalnya bisa, jika pake ini sudah tidak bisa
        timeout(time: 10, unit: "MINUTES") // aborted / dibatalkan jika lewat

    }

    // bisa ditaruh spesifik stage
    parameters {
        string(name: 'DEPLOY_ENV', defaultValue: 'staging', description: 'Deploy environtment')
    }

    // bagian dari configure pipeline
    triggers {
        // cron("* * * * *")
        pollSCM('* * * * *')
    }

    // bisa ditaruh spesifik stage
    agent {
        node {
            label "linux && dotnet6"
        }
    }

    stages {

        stage("Setup OS Matrix") {
            matrix {
                axes {
                    axis {
                        name "OS"
                        values "linux", "windows"
                    }
                    axis {
                        name "ARC"
                        values "32", "64"
                    }
                }

                excludes {
                    exclude {
                        // nanti yang OS linux dengan 32 bit tidak akan dibuat
                        axis {
                            name 'OS'
                            values 'linux'
                        }
                        axis {
                            name 'ARC'
                            values '32'
                        }
                    }
                }

                stages {
                    stage("Setup OS") {
                        steps {
                            echo "Setup ${OS}:${ARC}"
                        }
                    }
                }
            }
        }

        stage("Preparation") {
            // setelah menggunakan parralel tidak dapat menambahkan agent node diatasnya
            // stages {} 
            parallel {
                stage("Prepare Dotnet") {
                    steps {
                        echo "Step Prepare Dotnet"
                        sleep(5)
                    }
                }

                stage("Prepare Docker") {
                    steps {
                        echo "Step Prepare Docker"
                    }
                }
            }
        }

        stage("Parameter") {
            steps {
                // jika global ambil menggunakan params jika parameter didalam stage tidak perlu pake params
                echo "Deploy env: ${params.DEPLOY_ENV}" 
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
            input {
                message "Deploy project now?"
                ok "Yes, of course"
                submitter "renaldi"
                parameters {
                    choice(name: 'DEPLOY', choices: ['DEV', 'UAT', 'PROD'], description: 'Deploy ENV')
                }
            }

            steps {

                echo("Target ENV Param di stage: ${DEPLOY}")

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

        stage("Release") {
            when { environment name: 'AUTHOR', value: 'Renaldi' } // contoh aja :D
            steps {
                withCredentials([usernamePassword(
                    credentialsId: "try_env_credential",
                    usernameVariable: "USER",
                    passwordVariable: "PASSWORD "

                )]) {
                    sh('echo "credential with -u $USER -p $PASSWORD" > "release.txt"')
                }
                echo("Release it")
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