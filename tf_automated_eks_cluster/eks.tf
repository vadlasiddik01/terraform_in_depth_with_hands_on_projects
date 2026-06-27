module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name               = local.name
  kubernetes_version = "1.33"

  # Optional, means k8s admin access so you can run kubectl get pods like this
  endpoint_public_access = true

  # Optional: Adds the current caller identity as an administrator via cluster access entry
  enable_cluster_creator_admin_permissions = true

  #   compute_config = {     it's for auto mode of node-grps scaling
  #     enabled    = true
  #     node_pools = ["general-purpose"]
  #   }

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets #using for running apps(ec2) that's y
  control_plane_subnet_ids = module.vpc.intra_subnets   #for control plane manager
  addons = {
    vpc-cni = {
      before_compute              = true
      most_recent                 = true
      resolve_conflicts_on_create = "OVERWRITE"
      resolve_conflicts_on_update = "OVERWRITE"
      timeouts = {
        create = "20m"
        update = "20m"
        delete = "20m"
      }
    }

    kube-proxy = {
      most_recent                 = true
      resolve_conflicts_on_create = "OVERWRITE"
      resolve_conflicts_on_update = "OVERWRITE"
      timeouts = {
        create = "20m"
        update = "20m"
        delete = "20m"
      }
    }

    coredns = {
      most_recent                 = true
      resolve_conflicts_on_create = "OVERWRITE"
      resolve_conflicts_on_update = "OVERWRITE"
      #for learnings only, we are using 1 replicaCount, in prod we can use 2 replicaCount for high availability.
      configuration_values = jsonencode({
        replicaCount = 1
      })
      timeouts = {
        create = "20m"
        update = "20m"
        delete = "20m"
      }

    }
  }
  eks_managed_node_groups = {
    tws_eks_ng = {
      ami_type       = "AL2023_x86_64_STANDARD" #installs version suited optimized ami id image
      instance_types = ["t3.micro"]
      min_size       = 1
      max_size       = 4
      desired_size   = 2

      capacity_type = "ON_DEMAND"
      #in prod uses "ON_DEMAND" bcoz when aws needs space that spot spaces removed with 2mins warning.

      attach_cluster_primary_security_group = false
      #This helps communication between:       Control Plane ↔ Worker Nodes
      #The ALB controller requires each ENI to have exactly one kubernetes.io/cluster/<cluster-name> security group tag.
      #With the cluster SG attached to nodes, the worker ENI likely had a second tag and broke ALB reconciliation.
    }
  }
  node_security_group_tags = {
    "karpenter.sh/discovery" = local.name
  }
  tags = local.common_tags
}
