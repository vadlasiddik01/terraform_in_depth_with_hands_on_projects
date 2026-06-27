resource "aws_dynamodb_table" "remote_backend_tfstate_dynamodb" {
  name         = "remote-backend-tfstate-dynamodb"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

}