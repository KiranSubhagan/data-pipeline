variable "aws_region" {
  default = "us-east-1"
}

variable "project_name" {
  default = "ecs-sqs-msk"
}

variable "vpc_id" {}
variable "private_subnet_ids" {
  type = list(string)
}

variable "sqs_queue_url" {}
variable "sqs_queue_arn" {}

variable "msk_bootstrap_servers" {}
variable "msk_cluster_arn" {}
variable "msk_topic" {
  default = "raw-topic"
}

variable "ecs_image_uri" {}
