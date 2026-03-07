resource "aws_eks_addon" "metrics_server" {
  cluster_name      = aws_eks_cluster.cluster.name
  addon_name        = "metrics-server"
  addon_version     = "v0.8.0-eksbuild.1"
  resolve_conflicts_on_update = "OVERWRITE"
}