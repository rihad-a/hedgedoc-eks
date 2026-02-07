# Setting up S3 for uploads

resource "aws_s3_bucket" "s3-upload" {
  bucket = var.s3-name
}

resource "aws_s3_bucket_policy" "s3-policy-attach" {
  bucket = aws_s3_bucket.s3-upload.id
  policy = data.aws_iam_policy_document.s3-policy.json
  
  depends_on = [aws_s3_bucket_public_access_block.s3-upload]
  
}

data "aws_iam_policy_document" "s3-policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "*"
      identifiers = [var.s3-role-arn]
    }

    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject"
    ]

    resources = [
      "arn:aws:s3:::s3-mediaupload/uploads/*"
    ]
  }
}

# Adding public access block to allow for a policy to be attached

resource "aws_s3_bucket_public_access_block" "s3-upload" {
  bucket = aws_s3_bucket.s3-upload.id

  block_public_acls       = var.block-public-acl
  block_public_policy     = var.block-public-policy
  ignore_public_acls      = var.ignore-public-acls
  restrict_public_buckets = var.restrict-public-buckets
}

