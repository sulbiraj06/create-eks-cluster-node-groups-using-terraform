terraform {
  backend "s3" {
    bucket = "website-terraform-us-east-1a-bucket"
    key    = "terraform/state"
  }
}
