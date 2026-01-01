output "github_action_secrets" {
  description = "Values to store as GitHub Action secrets for deploying the static site"
  value = {
    AWS_ROLE_TO_ASSUME         = aws_iam_role.this.arn
    AWS_ROLE_SESSION_NAME      = var.oidc_role_name
    AWS_REGION                 = data.aws_region.current.name
    S3_BUCKET_NAME             = aws_s3_bucket.this.bucket
    CLOUDFRONT_DISTRIBUTION_ID = aws_cloudfront_distribution.this.id
  }
}
