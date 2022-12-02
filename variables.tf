variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-1"
}

variable "profile" {
  description = "AWS credentials profile"
  type        = string
  default     = "personal"
}

# variable "worker_iam_policy" {
#   description = "IAM policy ARN for k8s workers"
#   type        = string
#   default     = aws_iam_policy.default_node.arn
# }