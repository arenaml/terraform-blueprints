variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "iam_role_names" {
  description = "IAM role names to attach this policy to"
  type        = list(string)
}

variable "s3_bucket_arns" {
  description = "List of ARNs of the S3 buckets for which to grant access to"
  type        = list(string)
}