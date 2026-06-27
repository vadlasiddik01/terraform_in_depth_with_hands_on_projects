resource "aws_dynamodb_table" "modules_remote_backend_tfstate_dynamodb" {
  name         = "${var.env}-remote-backend-tfstate-dynamodb"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = var.hash_key

  attribute {
    name = var.hash_key
    type = "S"
  }

  tags = {
    Name = "${var.env}-remote-backend-tfstate-dynamodb"
    Environment = var.env
  }
}