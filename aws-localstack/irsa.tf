# IRSA: a Kubernetes ServiceAccount gets an IAM role without static keys.
# EKS publishes an OIDC issuer; the role trusts tokens from that issuer
# only for one namespace/serviceaccount. Pods get temporary creds via STS
# AssumeRoleWithWebIdentity. (Newer alternative: EKS Pod Identity.)
locals {
  oidc_host = "oidc.eks.eu-central-1.amazonaws.com/id/EXAMPLE0123456789"
  sa        = "system:serviceaccount:urls:url-shortener"
}

resource "aws_iam_openid_connect_provider" "eks" {
  url             = "https://${local.oidc_host}"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["9e99a48a9960b14926bb7f3b02e22da2b0ab7280"]
}

data "aws_iam_policy_document" "trust" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.eks.arn]
    }
    condition {
      test     = "StringEquals"
      variable = "${local.oidc_host}:sub"
      values   = [local.sa]
    }
    condition {
      test     = "StringEquals"
      variable = "${local.oidc_host}:aud"
      values   = ["sts.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "app" {
  name               = "url-shortener"
  assume_role_policy = data.aws_iam_policy_document.trust.json
}

# Least privilege: read one bucket prefix only.
data "aws_iam_policy_document" "app" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.state.arn}/app/*"]
  }
}

resource "aws_iam_role_policy" "app" {
  role   = aws_iam_role.app.id
  policy = data.aws_iam_policy_document.app.json
}
