pipeline {
    agent any

    parameters {
        choice(name: 'DESTROY_INFRA', choices: ['No', 'Yes'], description: 'Destroy infrastructure?')
    }

    environment {
        AWS_ACCESS_KEY_ID     = credentials('AKIAXNGUVLXLRSZZXBHJ')     // Jenkins credential ID
        AWS_SECRET_ACCESS_KEY = credentials('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') // Jenkins credential ID
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
            when {
                expression { params.DESTROY_INFRA == 'Yes' }
            }
            steps {
                script {
                    sh 'terraform destroy -auto-approve -var-file=../terraform/terraform.tfvars'
                }
            }
        }
    }
}