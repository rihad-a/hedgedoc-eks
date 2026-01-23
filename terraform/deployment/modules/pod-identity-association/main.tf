# EKS Pod Identity Association

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["pods.eks.amazonaws.com"]
    }

    actions = [
      "sts:AssumeRole",
      "sts:TagSession"
    ]
  }
}

resource "aws_iam_role" "pod_identity" {
  name               = var.podidentity-rolename
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "s3" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
  role       = aws_iam_role.pod_identity.name
}

resource "aws_eks_pod_identity_association" "pod_identity" {
  cluster_name    = var.ekscluster-name
  namespace       = var.podidentity-namespace
  service_account = var.podidentity-sa
  role_arn        = aws_iam_role.pod_identity.arn

}

# Setting up certificate manager

resource "aws_iam_role" "cert-manager" {
  name               = var.certmanager-rolename
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_policy" "cert-manager" {
  name = var.certmanager-policyname

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect" : "Allow",
        "Action" : "route53:GetChange",
        "Resource" : "arn:aws:route53:::change/*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "route53:ChangeResourceRecordSets",
          "route53:ListResourceRecordSets"
        ],
        "Resource" : "arn:aws:route53:::hostedzone/*",
        "Condition" : {
          "ForAllValues:StringEquals" : {
            "route53:ChangeResourceRecordSetsRecordTypes" : ["TXT"]
          }
        }
      },
      {
        "Effect" : "Allow",
        "Action" : "route53:ListHostedZonesByName",
        "Resource" : "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "cert-manager" {
  policy_arn = aws_iam_policy.cert-manager.arn
  role       = aws_iam_role.cert-manager.name
}

resource "aws_eks_pod_identity_association" "cert-manager" {
  cluster_name    = var.ekscluster-name
  namespace       = var.certmanager-namespace
  service_account = var.certmanager-sa
  role_arn        = aws_iam_role.cert-manager.arn

}

# Setting up external dns

resource "aws_iam_role" "external-dns" {
  name               = var.extdns-rolename
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_policy" "external-dns" {
  name = var.extdns-policyname

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "route53:ChangeResourceRecordSets"
        ],
        "Resource" : [
          "arn:aws:route53:::hostedzone/*"
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "route53:ListHostedZones",
          "route53:ListResourceRecordSets",
          "route53:ListTagsForResource"
        ],
        "Resource" : [
          "*"
        ]
      }
    ]
    }
  )
}

resource "aws_iam_role_policy_attachment" "external-dns" {
  policy_arn = aws_iam_policy.external-dns.arn
  role       = aws_iam_role.external-dns.name
}

resource "aws_eks_pod_identity_association" "external-dns" {
  cluster_name    = var.ekscluster-name
  namespace       = var.extdns-namespace
  service_account = var.extdns-sa
  role_arn        = aws_iam_role.external-dns.arn

}