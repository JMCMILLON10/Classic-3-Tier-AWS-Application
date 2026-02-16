resource "aws_dynamodb_table" "app" {
  name         = "classic-app-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }

  tags = { Name = "classic-app-table" }
}