terraform {
  backend "s3" {
    bucket         = "zafar-bucket-786"
    key            = "dev/terraform.tfstate"
    region         = "ap-south-1"
    # dynamodb_table = "terraform-locks"  # Optional but recommended
    encrypt        = true
  }
}
