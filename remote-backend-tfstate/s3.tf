resource "aws_s3_bucket" "remote_backend_tfstate_s3" {
  bucket = "remote-backend-tfstate-s3"

  tags = {
    Name        = "remote-backend-tfstate-s3"

  }
}