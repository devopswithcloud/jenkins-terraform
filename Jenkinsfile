pipeline {
    agent any 
    parameters {
        choice(
            name: 'ENVIRONMENT',
            choices: ['dev', 'test', 'stage', 'prod'],
            description: 'Select Environment'
        )
        choice(
            name: 'ACTION',
            choices: "validate\nplan\napply\ndestroy",
            description: 'Choose terraform workflow'
        )
    }
    environment {
        S3_BUCKET = "i27academy-tf-devopsb5"
        AWS_REGION = "us-east-1"
        STATE_FILE_KEY = "${params.ENVIRONMENT}/terraform.tfstate"
        TFVARS_FILE="${params.ENVIRONMENT}.tfvars"
    }
    stages {
        stage ('init') {
            steps {
                sh """
                terraform init -reconfigure \
                    -backend-config="bucket=${S3_BUCKET}" \
                    -backend-config="key=${STATE_FILE_KEY}" \
                    -backend-config="region=${AWS_REGION}"
                """
            }
        }
        stage ('validate') {
            when {
                expression {
                    params.ACTION == 'validate'
                }
            }
            steps {
                sh """
                terraform validate
                """
            }
        }
        stage ('plan') {
            when {
                expression {
                    params.ACTION == 'plan'
                }
            }
            steps {
                sh """
                terraform plan -var-file=${TFVARS_FILE}
                """
            }
        }
        stage ('apply') {
            when {
                expression {
                    params.ACTION == 'apply'
                }
            }
            steps {
                timeout(time: 300, unit: 'SECONDS') {
                    input message: 'Are you sure to apply changes?', ok: 'yes', submitter: 'i27academy,siva'
                }
                sh """
                terraform apply -var-file=${TFVARS_FILE} --auto-approve
                """
            }
        }
        stage ('destroy') {
            when {
                expression {
                    params.ACTION == 'destroy' --auto-approve
                }
            }
            steps {
                timeout(time: 300, unit: 'SECONDS') {
                    input message: 'Are you sure to destroy Infra?', ok: 'yes', submitter: 'i27academy,siva'
                }
                sh """
                terraform destroy -var-file=${TFVARS_FILE}
                """
            }
        }
    }
}