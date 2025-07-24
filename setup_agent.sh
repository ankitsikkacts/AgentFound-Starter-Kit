aws iam create-user --user-name agent-iam-user
aws iam attach-user-policy --user-name agent-iam-user --policy-arn arn:aws:iam::aws:policy/AmazonBedrockFullAccess
aws iam create-access-key --user-name agent-iam-user


#!/bin/bash

# Define the first policy document
POLICY_DOC_1=$(cat <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "cloudwatch:GetMetricData",
      "Resource": "*"
    }
  ]
}
EOF
)

# Apply the first policy
aws iam put-user-policy \
  --user-name agent-iam-user \
  --policy-name AllowCloudWatchGetMetricData \
  --policy-document "$POLICY_DOC_1"

# Define the second policy document
POLICY_DOC_2=$(cat <<EOF
{
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
        "arn:aws:logs:us-east-1:<PRJ_ID>:log-group:/aws/bedrock/model-invocations:*",
        "arn:aws:logs:us-east-1:<PRJ_ID>:log-group:/aws/bedrock/model-invocations"
      ]
    }
  ]
}
EOF
)

# Apply the second policy
aws iam put-user-policy \
  --user-name agent-iam-user \
  --policy-name BedrockLogsAccess \
  --policy-document "$POLICY_DOC_2"


aws iam create-user --user-name math-iam-user
aws iam attach-user-policy --user-name math-iam-user --policy-arn arn:aws:iam::aws:policy/AmazonBedrockFullAccess
aws iam create-access-key --user-name math-iam-user
