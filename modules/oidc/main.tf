data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "this" {
  version = "2012-10-17"

  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    principals {
      type        = "Federated"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${var.oidc_issuer}"]
    }

    condition {
      test     = "StringEquals"
      variable  = "${var.oidc_issuer}:aud"
      values = ["${var.oidc_audience}"]
    }

    condition {
      test     = "StringLike"
      variable   = "${var.oidc_issuer}:sub"
      values = ["${var.oidc_subject}"]
    }
  }
}

resource "aws_iam_role" "this" {
  name               = var.oidc_role_name
  assume_role_policy = data.aws_iam_policy_document.this.json
}

resource "aws_iam_role_policy_attachment" "s3_full_access_attachment" {
  role       = var.oidc_role_name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"

  depends_on = [aws_iam_role.this]
}

resource "aws_iam_role_policy_attachment" "cloudfront_full_access_attachment" {
  role       = var.oidc_role_name
  policy_arn = "arn:aws:iam::aws:policy/CloudFrontFullAccess"
  
  depends_on = [aws_iam_role.this]
}

data "tls_certificate" "this" {
  url = "https://${var.oidc_issuer}/.well-known/openid-configuration"
}

resource "aws_iam_openid_connect_provider" "this" {
  url             = "https://${var.oidc_issuer}"
  client_id_list = ["${var.oidc_audience}"]
  thumbprint_list = ["${data.tls_certificate.this.certificates[0].sha1_fingerprint}"]
}
