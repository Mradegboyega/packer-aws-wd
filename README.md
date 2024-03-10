Packer AWS AMI Build

This repository contains the necessary configuration files and scripts to build an Amazon Machine Image (AMI) using Packer for AWS EC2 instances.
Prerequisites

    AWS Account: Ensure you have an AWS account with the necessary permissions to create EC2 instances and manage IAM roles.

    Packer Installation: Make sure Packer is installed on your local machine. You can download it from the official website or use a package manager.

    AWS CLI Configuration: Configure the AWS CLI with your AWS credentials:

    bash

    aws configure

IAM Permissions

To successfully build an AMI with Packer, the IAM user or role used must have the following permissions:

json

{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeImages",
                "ec2:DescribeInstances",
                "ec2:CreateTags",
                "ec2:RunInstances",
                "ec2:CreateKeyPair",
                "ec2:CreateSecurityGroup"
            ],
            "Resource": "*"
        }
    ]
}

This policy grants necessary EC2 permissions for Packer to create instances, key pairs, and security groups.

Note: Be cautious when assigning permissions. The provided policy is permissive for testing purposes. In a production environment, follow the principle of least privilege.
Packer Build

To build the AMI, run the following command:

bash

packer build .

This command will use the configuration file (packer.json or any specified file) to create an EC2 instance, provision it, and create an AMI.
Cleaning Up

After the Packer build is complete, ensure to clean up any resources created during the process:

    Manually Delete Key Pair: If Packer fails to clean up the key pair, manually delete it using the AWS Management Console or AWS CLI.

    Review IAM Permissions: Review and adjust IAM permissions based on actual requirements. Do not use broad permissions in a production environment.

Troubleshooting

If you encounter issues during the build process, review the error messages and update IAM policies accordingly. Follow the AWS documentation for IAM policy management.
