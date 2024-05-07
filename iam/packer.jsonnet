local region = std.extVar('region');
local bucket_suffix = std.extVar('bucket_suffix');

{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ec2:AllocateAddress",
                "ec2:AttachVolume",
                "ec2:AuthorizeSecurityGroupIngress",
                "ec2:CopyImage",
                "ec2:CreateImage",
                "ec2:CreateKeypair",
                "ec2:CreateSecurityGroup",
                "ec2:CreateSnapshot",
                "ec2:CreateVpc",
                "ec2:CreateTags",
                "ec2:CreateVolume",
                "ec2:DeleteKeypair",
                "ec2:DeleteSecurityGroup",
                "ec2:DeleteSnapshot",
                "ec2:DeleteVolume",
                "ec2:DeregisterImage",
                "ec2:DescribeKeyPairs",
                "ec2:DescribeImageAttribute",
                "ec2:DescribeImages",
                "ec2:DescribeInstances",
                "ec2:DescribeRegions",
                "ec2:DescribeSecurityGroups",
                "ec2:DescribeSnapshots",
                "ec2:DescribeSubnets",
                "ec2:DescribeTags",
                "ec2:DescribeVolumes",
                "ec2:DetachVolume",
                "ec2:GetPasswordData",
                "ec2:ModifyImageAttribute",
                "ec2:RegisterImage",
                "ec2:RunInstances",
                "ec2:StopInstances",
                "ec2:TerminateInstances",
                "ecs:CreateCluster",
                
            ],
            "Resource": "*",
            "Condition": {
                "StringEqualsIfExists": {
                    "aws:RequestedRegion": region
                }
            }
        },
        {
            "Effect": "Allow",
            "Action": [
                "iam:CreateRole"
            ],
            "Resource": "*"
        }
        {
            "Effect": "Allow",
            "Action": "s3:ListBucket",
            "Resource": [
                std.strReplace("arn:aws:s3:::terraform-backend-state-<suffix>/*", "<suffix>", bucket_suffix),
                std.strReplace("arn:aws:s3:::terraform-backend-state-<suffix>", "<suffix>", bucket_suffix)
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObject",
                "s3:PutObject"
            ],
            "Resource": std.strReplace("arn:aws:s3:::terraform-backend-state-<suffix>/*/terraform.tfstate", "<suffix>", bucket_suffix)
        },
        {
            "Effect": "Allow",
            "Action": [
                "dynamodb:DescribeTable",
                "dynamodb:GetItem",
                "dynamodb:PutItem",
                "dynamodb:DeleteItem",
                "dynamodb:Scan"
            ],
            "Resource": "arn:aws:dynamodb:*:*:table/terraform_state_lock"
        }        
    ]
}
