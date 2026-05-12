pipeline {
    agent any

    environment {
        ARM_CLIENT_ID       = credentials('client-id')
        ARM_CLIENT_SECRET   = credentials('client-secret')
        ARM_TENANT_ID       = credentials('tenant-id')
        ARM_SUBSCRIPTION_ID = credentials('subscription-id')
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                dir('terraform_devsecops_lob') {
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir('terraform_devsecops_lob') {
                    sh 'terraform plan -var-file="variables.tfvars" -out=tfplan'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                dir('terraform_devsecops_lob') {
                    sh 'terraform apply -var-file="variables.tfvars" -auto-approve'
                }
            }
        }
    }
}