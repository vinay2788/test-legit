terraform {
  backend "s3" {
    bucket  = "terraform-state-2712"    # Replace with your S3 bucket name
    key     = "state/terraform.tfstate" # Path to your state file in the bucket
    region  = "ap-south-1"              # Replace with your AWS region
    encrypt = true
    #dynamodb_table = "your-lock-table"                # Optional: for state locking
  }
}