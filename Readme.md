# Terraform AWS Infrastructure CI/CD Pipeline

This repository contains Terraform code and a Jenkins pipeline for provisioning and managing AWS infrastructure using Infrastructure as Code (IaC) principles.

## AWS Architecture Overview

Below is a sample architecture diagram representing the kind of AWS resources you can provision and manage with this repository.  
_You can update the image with your actual architecture if needed._


## Repository Structure

```
.
├── Jenkinsfile           # Jenkins pipeline definition
├── terraform.tfvars      # Terraform variables file (ensure this exists)
├── main.tf               # Main Terraform configuration 
├── variables.tf          # Terraform variables definition 
├── provider.tf           # Terraform provider configuration 
├── output.tf             # Terraform outputs definition 
├── azure-pipeline.yml    # Azure DevOps pipeline definition for Terraform on AWS
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

## Azure DevOps Pipeline

This repository also includes an Azure DevOps pipeline definition (`azure-pipeline.yml`) for provisioning and managing AWS infrastructure using Terraform.

### Pipeline Features

- **Automatic Trigger:** Runs on every push to the `main` branch.
- **Terraform Tasks:** Installs Terraform, initializes the backend, plans, applies, and (optionally) destroys infrastructure.
- **AWS Integration:** Uses an AWS service connection for authentication and state management.
- **Conditional Destroy:** The `destroy` step runs only if the `destroyInfra` parameter is set to `true` at runtime.

### Pipeline Parameters

- **destroyInfra**: Boolean parameter. Set to `true` at runtime to enable the destroy step and tear down the infrastructure.

### How to Use

1. **Service Connection:**  
   Create an AWS service connection in Azure DevOps named `AWS-Terraform-Service-Connection` with appropriate permissions.

2. **Configure Pipeline:**  
   - Place `azure-pipeline.yml` in the root of your repository.
   - Adjust backend bucket/key/region as needed.

3. **Run Pipeline:**  
   - By default, the pipeline provisions infrastructure on every push to `main`.
   - To destroy infrastructure, run the pipeline manually and set the `destroyInfra` parameter to `true`.

### Example Pipeline Steps

- **Terraform Init:** Initializes Terraform and configures the backend.
- **Terraform Plan:** Previews infrastructure changes.
- **Terraform Apply:** Applies the planned changes.
- **Terraform Destroy:** (Optional) Destroys all managed infrastructure if enabled.

---

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