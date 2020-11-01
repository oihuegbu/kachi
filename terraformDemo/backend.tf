
/*terraform {
    backend "remote" {
        hostname = "app.terraform.io"
        organization = "kachi"

        workspaces {
            name = "kachi3"
        }
    }
}*/



terraform {
  backend "s3" {
    bucket = "kashbucket860"
    key    = "kashbucket860/terraform-state"
    region = "us-east-1"
  }
}
