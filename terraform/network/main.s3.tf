resource "aws_s3_bucket" "this" {
  count  = var.manage_s3_bucket_for_load_balancer ? 1 : 0
  bucket = local.s3_bucket_name

  tags = var.tags
}

resource "aws_s3_bucket_policy" "this" {
  count  = var.manage_s3_bucket_for_load_balancer ? 1 : 0
  bucket = aws_s3_bucket.this[0].bucket
  policy = data.aws_iam_policy_document.load_balancer_to_s3[0].json
}

data "aws_iam_policy_document" "load_balancer_to_s3" {
  count = var.manage_s3_bucket_for_load_balancer && var.manage_load_balancer ? 1 : 0
  statement {
    effect = "Allow"
    actions = [
      "s3:PutObject",
    ]
    resources = [
      "${aws_s3_bucket.this[0].arn}/*"
    ]
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${local.aws_elb_account_ids[data.aws_region.current.name]}:root"
      ]
    }
  }
}
