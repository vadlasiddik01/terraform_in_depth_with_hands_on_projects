resource "kubernetes_manifest" "karpenter_ec2_nodeclass" {
  manifest = yamldecode(<<-YAML
apiVersion: karpenter.k8s.aws/v1
kind: EC2NodeClass
metadata:
  name: default
spec:
  amiSelectorTerms:
   - alias: al2023@latest


  role: ${aws_iam_role.karpenter_node.name}

  subnetSelectorTerms:
    - tags:
        karpenter.sh/discovery: ${local.name}

  securityGroupSelectorTerms:
    - tags:
        karpenter.sh/discovery: ${local.name}

  tags:
    Name: ${local.name}-karpenter
    karpenter.sh/discovery: ${local.name}
YAML
  )
}

resource "kubernetes_manifest" "karpenter_nodepool" {

  depends_on = [
    kubernetes_manifest.karpenter_ec2_nodeclass
  ]

  manifest = yamldecode(<<-YAML
apiVersion: karpenter.sh/v1
kind: NodePool
metadata:
  name: default

spec:
  template:
    metadata:
      labels:
        nodepool: default

    spec:
      nodeClassRef:
        group: karpenter.k8s.aws
        kind: EC2NodeClass
        name: default

      requirements:
        - key: kubernetes.io/arch
          operator: In
          values:
            - amd64

        - key: kubernetes.io/os
          operator: In
          values:
            - linux

        - key: karpenter.k8s.aws/instance-category
          operator: In
          values:
            - t
            - m
            - c

        - key: karpenter.k8s.aws/instance-generation
          operator: Gt
          values:
            - "2"

        - key: karpenter.sh/capacity-type
          operator: In
          values:
            - on-demand

  limits:
    cpu: "20"

  disruption:
    consolidationPolicy: WhenEmptyOrUnderutilized
    consolidateAfter: 30s
YAML
  )
}