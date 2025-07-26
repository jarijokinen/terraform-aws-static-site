variable "oidc_issuer" {
  description = "The OIDC issuer URL"
  type        = string
}

variable "oidc_audience" {
  description = "The OIDC audience"
  type        = string
}

variable "oidc_subject" {
  description = "The OIDC subject"
  type        = string
}

variable "oidc_role_name" {
  description = "The name of the OIDC role"
  type        = string
}
