module "karpenter_irsa" {

  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.0"
  #"~> 6.0 needed bcoz warning cming"

  role_name = "${local.name}-karpenter"

  # Karpenter permissions
  attach_karpenter_controller_policy = true
  karpenter_controller_cluster_name  = module.eks.cluster_name
  karpenter_controller_node_iam_role_arns = [
    aws_iam_role.karpenter_node.arn
  ]
  enable_karpenter_instance_profile_creation = true

  oidc_providers = {
    ex = {
      provider_arn = module.eks.oidc_provider_arn

      namespace_service_accounts = [
        "karpenter:karpenter"
      ]
    }
  }
}
resource "aws_iam_role" "karpenter_node" {
  name = "${local.name}-karpenter-node"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "sts:AssumeRole"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = local.common_tags
}

resource "aws_iam_role_policy_attachment" "karpenter_node_worker" {
  role       = aws_iam_role.karpenter_node.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "karpenter_node_cni" {
  role       = aws_iam_role.karpenter_node.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "karpenter_node_ecr" {
  role       = aws_iam_role.karpenter_node.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_role_policy_attachment" "karpenter_node_ssm" {
  role       = aws_iam_role.karpenter_node.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_policy" "karpenter_instance_profile" {

  name = "${local.name}-karpenter-instance-profile"

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "iam:CreateInstanceProfile",
          "iam:GetInstanceProfile",
          "iam:DeleteInstanceProfile",
          "iam:AddRoleToInstanceProfile",
          "iam:RemoveRoleFromInstanceProfile",
          "iam:ListInstanceProfiles",
          "iam:TagInstanceProfile"
        ]

        Resource = "arn:aws:iam::*:instance-profile/*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "karpenter_instance_profile" {

  role       = module.karpenter_irsa.iam_role_name
  policy_arn = aws_iam_policy.karpenter_instance_profile.arn
}
