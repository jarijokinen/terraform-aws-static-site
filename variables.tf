variable "domain_name" {
  description = "The domain name for the website"
  type        = string
}

variable "cloudfront_viewer_request_handler_arn" {
  description = "The ARN of the CloudFront function to handle viewer requests"
  type        = string
}

variable "github_repository" {
  description = "The GitHub repository that should have an access to the S3 bucket and CloudFront distribution"
  type        = string
}
