moved {
  from = module.eks.aws_eks_addon.this["vpc-cni"]
  to   = module.eks.aws_eks_addon.before_compute["vpc-cni"]
}

#You only need this if you are not destroying first. 
#If you do full terraform destroy and fresh terraform apply, you don’t need moved.tf.