pipeline {
    agent any

    options {
        disableConcurrentBuilds()
        timestamps()
    }

    parameters {
        choice(
            name: 'ENV',
            choices: ['dev', 'qa', 'prod'],
            description: 'Select Environment'
        )

        choice(
            name: 'ACTION',
            choices: ['plan', 'apply', 'destroy'],
            description: 'Select the action to perform'
        )
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scmGit(
                    branches: [[name: '*/main']],
                    extensions: [],
                    userRemoteConfigs: [[url: '']]
                )
            }
        }

        stage("Prepare Variables") {
            steps {
                script {
                    env.TF_VARS = "env/${params.ENV}/terraform.tfvars"

                    if (!fileExists(env.TF_VARS)) {
                        error "Environment ${params.ENV} not configured! Missing ${env.TF_VARS}"
                    }

                    echo "Using tfvars: ${env.TF_VARS}"
                }
            }
        }

        stage("Terraform Init") {
            steps {
                sh "terraform init -reconfigure"
            }
        }

        stage("Bootstrap Workspaces") {
            steps {
                sh '''
                for ws in dev qa prod
                do
                    if terraform workspace list | grep -w $ws
                    then
                        echo "Workspace $ws already exists"
                    else
                        echo "Creating workspace $ws"
                        terraform workspace new $ws
                    fi
                done
                '''
            }
        }

        stage("Select Workspace") {
            steps {
                sh "terraform workspace select ${params.ENV}"
            }
        }

        stage("Terraform Validate") {
            steps {
                sh "terraform validate"
            }
        }

        stage("Terraform Plan") {
            when { expression { params.ACTION == 'plan' } }
            steps {
                sh "terraform plan -var-file=${env.TF_VARS}"
            }
        }

        stage("Terraform Apply") {
            when { expression { params.ACTION == 'apply' } }
            steps {
                timeout(time: 5, unit: 'MINUTES') {
                    input message: "Apply ${params.ENV} infrastructure?"
                }
                sh "terraform apply -auto-approve -var-file=${env.TF_VARS}"
            }
        }

        stage("Protect Production") {
            when { expression { params.ACTION == 'destroy' && params.ENV == 'prod' } }
            steps {
                error "Destroy is NOT allowed in production!"
            }
        }

        stage("Terraform Destroy") {
            when { expression { params.ACTION == 'destroy' && params.ENV != 'prod' } }
            steps {
                timeout(time: 5, unit: 'MINUTES') {
                    input message: "Destroy ${params.ENV} infrastructure?"
                }
                sh "terraform destroy -auto-approve -var-file=${env.TF_VARS}"
            }
        }
    }
}
