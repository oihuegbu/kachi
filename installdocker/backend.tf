#Remote backend used in order to ensure accessibility on any machine
terraform {
  backend "s3" {
    bucket = "kashbucket860"
    key    = "kashbucket860/terraform-state"
    region = "us-east-1"
  }
}
