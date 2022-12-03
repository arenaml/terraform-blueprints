variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "iam_role_names" {
  description = "IAM role names to attach this policy to"
  type        = list(string)
}

variable "s3_bucket_arn" {
  description = "ARN of the S3 bucket for which to grant access to"
  type        = string
}