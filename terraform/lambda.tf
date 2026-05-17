resource "aws_lambda_function" "processor" {
  function_name = "${var.project_name}-processor"
  role          = aws_iam_role.lambda_role.arn
  runtime       = "python3.12"
  handler       = "app.lambda_handler"

  filename         = "../lambda/lambda.zip"
  source_code_hash = filebase64sha256("../lambda/lambda.zip")

  timeout = 60
}

resource "aws_lambda_event_source_mapping" "msk" {
  event_source_arn  = var.msk_cluster_arn
  function_name     = aws_lambda_function.processor.arn
  starting_position = "LATEST"

  topics = [var.msk_topic]

  batch_size = 100
}
