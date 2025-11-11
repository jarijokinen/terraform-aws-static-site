variable "domain_name" {
  description = "The domain name for the website"
  type        = string
}

variable "cloudfront_viewer_request_handler_arn" {
  description = "The ARN of the CloudFront function to handle viewer requests"
  type        = string
}

variable "oidc_provider_arn" {
  description = "ARN of the existing GitHub OIDC provider"
  type        = string
}

variable "oidc_role_name" {
  type        = string
  description = "OIDC role name"
}

variable "oidc_subject" {
  type        = string
  description = "OIDC subject"
}
