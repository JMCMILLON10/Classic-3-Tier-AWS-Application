resource "aws_iam_instance_profile" "classic_profile" {
  name = "classic-app-profile"
  role = aws_iam_role.classic_app_role.name
}

data "aws_iam_policy_document" "classic_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "classic_app_role" {
  name               = "classic-app-ec2-role"
  assume_role_policy = data.aws_iam_policy_document.classic_assume_role.json
}

data "aws_iam_policy_document" "ddb_policy" {
  statement {
    actions = [
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:UpdateItem",
      "dynamodb:DeleteItem",
      "dynamodb:Query",
      "dynamodb:Scan"
    ]
    resources = [aws_dynamodb_table.app.arn]
  }
}

resource "aws_iam_policy" "ddb_policy" {
  name   = "classic-app-ddb-policy"
  policy = data.aws_iam_policy_document.ddb_policy.json
}

resource "aws_iam_role_policy_attachment" "app_ddb_attach" {
  role       = aws_iam_role.classic_app_role.name
  policy_arn = aws_iam_policy.ddb_policy.arn
}

resource "aws_iam_role_policy_attachment" "ssm_core" {
  role       = aws_iam_role.classic_app_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}