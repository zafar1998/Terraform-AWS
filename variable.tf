variable "aws_region" {
  description = "AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

variable "key_pair" {
  description = "The AWS key pair to use for the EC2 instance"
  type        = string
}

variable "artifact_bucket" {
  description = "Name of the S3 bucket to store application artifacts"
  type        = string
}

variable "ubuntu_ami_id" {
  description = "Static AMI ID for Ubuntu 20.04"
  type        = string
  default     = "ami-0f58b397bc5c1f2e8"
}