# Terraform AWS Infrastructure CI/CD Pipeline

This repository contains Terraform code and a Jenkins pipeline for provisioning and managing AWS infrastructure using Infrastructure as Code (IaC) principles.

## AWS Architecture Overview

Below is a sample architecture diagram representing the kind of AWS resources you can provision and manage with this repository.  
_You can update the image with your actual architecture if needed._

![AWS Architecture Example](https://raw.githubusercontent.com/aws-samples/aws-modern-application-workshop/master/images/architecture-overview.png)

## Repository Structure

```
.
├── Jenkinsfile           # Jenkins pipeline definition
├── terraform.tfvars      # Terraform variables file (ensure this exists)
├── main.tf               # Main Terraform configuration (example)
├── variables.tf          # Terraform variables definition (example)
└── Readme.md             # Project documentation
```

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) installed on your Jenkins agent
- [Jenkins](https://www.jenkins.io/) server with:
  - Pipeline plugin
  - AWS credentials configured as Jenkins credentials
- AWS account with necessary permissions

## Jenkins Pipeline Overview

The pipeline defined in `Jenkinsfile` performs the following stages:

1. **Git Clone**: Clones the repository.
2. **Initialize**: Runs `terraform init` to initialize the working directory.
3. **Plan**: Runs `terraform plan` using the provided `terraform.tfvars` file.
4. **Apply**: Applies the Terraform plan to provision/update infrastructure.
5. **Cleanup**: Optionally destroys the infrastructure if approved via a pipeline parameter.

## Pipeline Parameters

- **DESTROY_INFRA**: Choice parameter (`Yes`/`No`). Select `Yes` to destroy the infrastructure in the `Cleanup` stage.

## How to Run

1. **Clone the repository** (if running locally):
    ```sh
    git clone https://github.com/zafar1998/Terraform-AWS.git
    cd Terraform-AWS
    ```

2. **Configure Jenkins Credentials**:
    - Add your AWS Access Key and Secret Key as Jenkins credentials.
    - Update the `Jenkinsfile` to reference your Jenkins credential IDs if needed.

3. **Ensure `terraform.tfvars` exists**:
    - Place your variable values in `terraform.tfvars` in the root directory or update the path in the `Jenkinsfile` if it's located elsewhere.

4. **Run the Jenkins Pipeline**:
    - Start a new build.
    - Choose `Yes` or `No` for the `DESTROY_INFRA` parameter as required.

5. **Monitor the Pipeline**:
    - The pipeline will provision or destroy AWS resources based on your selection.

## Notes

- **Security**: Never commit sensitive information (like AWS keys) directly to the repository.
- **Terraform State**: Ensure your Terraform state is managed securely (consider using remote backends for production).

## Example `terraform.tfvars`

```hcl
aws_region = "ap-south-1"
instance_type = "t2.micro"
# Add other required variables here
```

---

**For any issues or questions, please open an issue or contact the repository maintainer.**