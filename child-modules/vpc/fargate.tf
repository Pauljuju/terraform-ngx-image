# fargate #

# resource "aws_eks_fargate_profile" "fargate" {
#   cluster_name           = aws_ecs_cluster.sika-cluster.name
#   fargate_profile_name   = "${var.project_name}-fargate-profile"
#   pod_execution_role_arn = aws_iam_role.sika_iam_role.arn
#   subnet_ids             = aws_subnet.sika_ptesub[*].id

#   selector {
#     namespace = "${var.project_name}-fargate"
#   }
# }