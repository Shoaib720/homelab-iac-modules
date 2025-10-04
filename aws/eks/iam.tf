resource "aws_kms_grant" "eks_nodes" {
  name              = "kms_grant_ecr_eks"
  key_id            = data.aws_kms_key.ecr_encryption_key.id
  grantee_principal = aws_iam_role.eks_node_role.arn

  operations = [
    "Decrypt",
    "Encrypt",
    "GenerateDataKey",
    "GenerateDataKeyWithoutPlaintext",
    "GenerateDataKeyPair",
    "GenerateDataKeyPairWithoutPlaintext"
  ]
}
