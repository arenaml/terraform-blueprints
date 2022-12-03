resource "aws_iam_policy" "s3" {
  name        = "${var.cluster_name}-access-s3"
  description = "Additional policy for eks cluster ${var.cluster_name} to access S3"
  path        = "/"
  policy      = data.aws_iam_policy_document.s3.json
}

data "aws_iam_policy_document" "s3" {
  statement {
    sid    = "S3"
    effect = "Allow"

    actions = [
      "s3:*",
      "kms:*",
    ]

    resources = [var.s3_bucket_arn]
  }
}

resource "aws_iam_role_policy_attachment" "s3" {
  role       = var.iam_role_names.0
  policy_arn = aws_iam_policy.s3.arn
}
