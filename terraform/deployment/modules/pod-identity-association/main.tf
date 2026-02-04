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

# Setting up EFS CSI Driver

resource "aws_iam_role" "efs-csi-driver-role" {
  name               = var.efs-csi-driver-rolename
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_policy" "efs-csi-driver-policy" {
  name = var.efs-csi-driver-policyname

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "AllowDescribe",
        "Effect" : "Allow",
        "Action" : [
          "elasticfilesystem:DescribeAccessPoints",
          "elasticfilesystem:DescribeFileSystems",
          "elasticfilesystem:DescribeMountTargets",
          "ec2:DescribeAvailabilityZones"
        ],
        "Resource" : "*"
      },
      {
        "Sid" : "AllowCreateAccessPoint",
        "Effect" : "Allow",
        "Action" : [
          "elasticfilesystem:CreateAccessPoint"
        ],
        "Resource" : "*",
        "Condition" : {
          "Null" : {
            "aws:RequestTag/efs.csi.aws.com/cluster" : "false"
          },
          "ForAllValues:StringEquals" : {
            "aws:TagKeys" : "efs.csi.aws.com/cluster"
          }
        }
      },
      {
        "Sid" : "AllowTagNewAccessPoints",
        "Effect" : "Allow",
        "Action" : [
          "elasticfilesystem:TagResource"
        ],
        "Resource" : "*",
        "Condition" : {
          "StringEquals" : {
            "elasticfilesystem:CreateAction" : "CreateAccessPoint"
          },
          "Null" : {
            "aws:RequestTag/efs.csi.aws.com/cluster" : "false"
          },
          "ForAllValues:StringEquals" : {
            "aws:TagKeys" : "efs.csi.aws.com/cluster"
          }
        }
      },
      {
        "Sid" : "AllowDeleteAccessPoint",
        "Effect" : "Allow",
        "Action" : "elasticfilesystem:DeleteAccessPoint",
        "Resource" : "*",
        "Condition" : {
          "Null" : {
            "aws:ResourceTag/efs.csi.aws.com/cluster" : "false"
          }
        }
      }
    ]
    }
  )
}

resource "aws_iam_role_policy_attachment" "efs-csi-driver" {
  policy_arn = aws_iam_policy.efs-csi-driver-policy.arn
  role       = aws_iam_role.efs-csi-driver-role.name
}

resource "aws_eks_pod_identity_association" "efs-csi-driver" {
  cluster_name    = var.ekscluster-name
  namespace       = var.efs-csi-driver-namespace
  service_account = var.efs-csi-driver-sa
  role_arn        = aws_iam_role.efs-csi-driver-role.arn

}

# Setting up role for external secrets operatore (ESO)

data "aws_secretsmanager_secret" "db-url" {
  arn = "arn:aws:secretsmanager:eu-west-2:291759414346:secret:db-url-OJNBM8"
}

resource "aws_iam_role" "eso-role" {
  name               = var.eso-rolename
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy_document" "eso-policy" {
    statement {
      effect = "Allow"
      actions = [
        "secretsmanager:GetResourcePolicy",
        "secretsmanager:GetSecretValue",
        "secretsmanager:DescribeSecret",
        "secretsmanager:ListSecretVersionIds"
      ]
      resources = [
        "*"
      ]
    }

}

resource "aws_iam_policy" "eso-policy" {
  name        = var.eso-policyname
  description = "Policy for ExternalSecretsOperator read content from SecretsManager"
  policy      = data.aws_iam_policy_document.eso-policy.json
}

resource "aws_iam_role_policy_attachment" "eso" {
  role       = aws_iam_role.eso-role.name
  policy_arn = aws_iam_policy.eso-policy.arn
}

resource "aws_eks_pod_identity_association" "eso" {
  cluster_name    = var.ekscluster-name
  namespace       = var.eso-namespace
  service_account = var.eso-sa
  role_arn        = aws_iam_role.eso-role.arn
}