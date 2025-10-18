resource "aws_eks_addon" "ebs_snapshot_controller" {
  cluster_name      = aws_eks_cluster.cluster.name
  addon_name        = "aws-ebs-csi-snapshot-controller"
  addon_version     = "v8.3.0-eksbuild.1"
  resolve_conflicts_on_update = "OVERWRITE"

  depends_on = [
    aws_eks_addon.ebs_csi_driver
  ]
}