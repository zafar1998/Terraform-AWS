pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = credentials('')     // Jenkins credential ID
        AWS_SECRET_ACCESS_KEY = credentials('') // Jenkins credential ID
        AWS_DEFAULT_REGION    = 'ap-south-1'
    }

    stages {
        stage('Git Clone') {
            steps {
                git branch: 'main', url: 'https://github.com/zafar1998/Terraform-AWS.git'
            }
        }

        stage('Initialize') {
            steps {
                script {
                    sh 'terraform init'
                }
            }
        }

        stage('Plan') {
            steps {
                script {
                    sh 'terraform plan -var-file=../terraform/terraform.tfvars'
                }
            }
        }

        stage('Apply') {
            steps {
                script {
                    sh 'terraform apply -auto-approve -var-file=../terraform/terraform.tfvars'
                }
            }
        }

        stage('Cleanup') {
            steps {
                script {
                    sh 'terraform destroy -auto-approve -var-file=../terraform/terraform.tfvars'
                }
            }
        }
    }
}