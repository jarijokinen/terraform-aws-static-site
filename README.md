# terraform-aws-static-site

Terraform module to host static sites on AWS S3 with CloudFront and Route53.

## Usage

```hcl
locals {
  sites = {
    "jarijokinen_com" = {
      domain_name = "jarijokinen.com"
      github_repository = "jarijokinen/jarijokinen-com"
    }
  }
}

resource "aws_cloudfront_function" "s3_viewer_request" {
  name    = "s3_viewer_request"
  runtime = "cloudfront-js-2.0"
  publish = true
  code = file("${path.module}/functions/s3_viewer_request.js")
}

module "static_site" {
  for_each = local.sites

  source = "github.com/jarijokinen/terraform-aws-static-site"
  cloudfront_viewer_request_handler_arn = aws_cloudfront_function.s3_viewer_request.arn
  domain_name = each.value.domain_name
  github_repository = each.value.github_repository

  providers = {
    aws = aws,
    aws.route53 = aws.route53
  }
}
```

## License

MIT License. Copyright (c) 2025 [Jari Jokinen](https://jarijokinen.com). See
[LICENSE](https://github.com/jarijokinen/terraform-aws-static-site/blob/main/LICENSE.txt) for further details.
