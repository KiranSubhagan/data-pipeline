resource "aws_glue_registry" "this" {
  registry_name = "event-registry"
}

resource "aws_glue_schema" "this" {
  registry_arn = aws_glue_registry.this.arn
  schema_name  = "event-schema"

  data_format = "JSON"

  schema_definition = jsonencode({
    type = "object"
    properties = {
      id = { type = "string" }
      payload = { type = "string" }
    }
  })

  compatibility = "BACKWARD"
}
