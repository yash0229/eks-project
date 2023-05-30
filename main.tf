provider "aws" {
region = "ap-south-1"
}

# Create an AWS EKS cluster
resource "aws_eks_cluster" "eks_cluster" {
 name     = "eks_project"
 version  = "1.23"
 role_arn = aws_iam_role.eks_cluster_role.arn
 vpc_config {
   subnet_ids = ["subnet-007ffd4edd64172e6" , "subnet-073d8a69bef796cec"]
   security_group_ids = ["sg-0673a49938d35bf51"]
 }
}

# Create an IAM role for the EKS cluster
resource "aws_iam_role" "eks_cluster_role" {
 name = "eks-project-role"
 assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "eks.amazonaws.com"
     },
     "Effect": "Allow",
"Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy_attachment" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_eks_node_group" "eks_node_group" {
cluster_name = aws_eks_cluster.eks_cluster.name
node_group_name = "my-node-group"
node_role_arn = aws_iam_role.eks_node_role.arn
subnet_ids = ["subnet-007ffd4edd64172e6" , "subnet-073d8a69bef796cec"]

scaling_config {
desired_size = 2
min_size = 1
max_size = 3
}

instance_types = ["t3.medium"]

remote_access {
ec2_ssh_key = "tf-project"
}

labels = {
"node-type" = "worker"
}

tags = {
"Environment" = "Testing"
}

}

resource "aws_iam_role" "eks_node_role" {
name = "my-eks-node-role"
assume_role_policy = <<EOF
{
"Version": "2012-10-17",
"Statement": [
{
"Effect": "Allow",
"Principal": {
"Service": "ec2.amazonaws.com"
},
"Action": "sts:AssumeRole"
}
]
}
EOF
}

resource "aws_security_group" "allow_ssh" {
name = "allow-ssh"
description = "Allow inbound SSH traffic"
vpc_id = "vpc-07e2fbe1076ff909e" 

ingress {
from_port = 22
to_port = 22
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}
}

resource "aws_iam_policy" "eks_worker_policy" {
name = "eks-worker-policy"
description = "Policy for EKS worker nodes"
policy = <<EOF
{
"Version": "2012-10-17",
"Statement": [
{
"Effect": "Allow",
"Action": [
"ec2:DescribeInstances",
"ec2:DescribeTags",
"ec2:DescribeRegions",
"ec2:DescribeRouteTables",
"ec2:DescribeSecurityGroups",
"ec2:DescribeSubnets",
"ec2:DescribeVpcs",
"ec2:DescribeVolumes",
"ec2:CreateSecurityGroup",
"ec2:CreateTags",
"ec2:CreateVolume",
"ec2:CreateVpcEndpoint",
"ec2:CreateRoute",
"ec2:CreateRouteTable",
"ec2:CreateSubnet",
"ec2:CreateNetworkInterface",
"ec2:RunInstances",
"ec2:TerminateInstances",
"ec2:AttachVolume",
"ec2:DetachVolume",
"ec2:DeleteSecurityGroup",
"ec2:DeleteTags",
"ec2:DeleteVolume",
"ec2:DeleteVpcEndpoint",
"ec2:DeleteRoute",
"ec2:DeleteRouteTable",
"ec2:DeleteSubnet",
"ec2:DeleteNetworkInterface",
"ec2:StopInstances",
"ec2:StartInstances"
],
"Resource": "*"
}
]
}
EOF
}

resource "aws_iam_role_policy_attachment" "eks_worker_policy_attachment" {
policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
role = aws_iam_role.eks_node_role.name
}

resource "aws_iam_role_policy_attachment" "ecr_policy_attachment" {
policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
role = aws_iam_role.eks_node_role.name
}

resource "aws_iam_role_policy_attachment" "cni_policy_attachment" {
policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
role = aws_iam_role.eks_node_role.name
}

