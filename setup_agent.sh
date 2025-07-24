#!/bin/bash

aws iam create-user --user-name agent-iam-user
aws iam attach-user-policy --user-name agent-iam-user --policy-arn arn:aws:iam::aws:policy/AmazonBedrockFullAccess
aws iam create-access-key --user-name agent-iam-user


# Policy document for CloudWatch GetMetricData
aws iam put-user-policy \
  --user-name agent-iam-user \
  --policy-name AllowCloudWatchGetMetricData \
  --policy-document '{
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": "cloudwatch:GetMetricData",
        "Resource": "*"
      }
    ]
  }'

# Policy document for Bedrock Logs Access
aws iam put-user-policy \
    --user-name agent-iam-user \
    --policy-name BedrockLogsAccess \
    --policy-document '{
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Action": [
                    "logs:FilterLogEvents",
                    "logs:DescribeLogGroups",
                    "logs:DescribeLogStreams"
                ],
                "Resource": [
                    "arn:aws:logs:us-east-1:345208593967:log-group:/aws/bedrock/model-invocations:*",
                    "arn:aws:logs:us-east-1:345208593967:log-group:/aws/bedrock/model-invocations"
                ]
            }
        ]
    }'


aws iam create-user --user-name math-iam-user
aws iam attach-user-policy --user-name math-iam-user --policy-arn arn:aws:iam::aws:policy/AmazonBedrockFullAccess
aws iam create-access-key --user-name math-iam-user
