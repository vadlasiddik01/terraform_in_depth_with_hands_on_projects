terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.49.0"
    }
  }


backend "s3" {
  bucket = "remote-backend-tfstate-s3"
  key = "terraform.tfstate"
  region = "us-east-1"
  dynamodb_table = "remote-backend-tfstate-dynamodb"
}

}