terraform {
  backend "s3" {
    bucket = "terraform-state-folder-project-raja"
    key    = "terraform/terraform.tfstate"
    region = "us-east-1"
  }
}
