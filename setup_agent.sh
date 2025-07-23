aws iam create-user --user-name agent-iam-user
aws iam attach-user-policy --user-name agent-iam-user --policy-arn arn:aws:iam::aws:policy/AmazonBedrockFullAccess
aws iam create-access-key --user-name agent-iam-user


aws iam put-user-policy \
  --user-name agent-iam-user \
  --policy-name AllowCloudWatchGetMetricData \
  --policy-document '{
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": "*",
        "Resource": "*"
      }
    ]
  }'


aws iam create-user --user-name math-iam-user
aws iam attach-user-policy --user-name math-iam-user --policy-arn arn:aws:iam::aws:policy/AmazonBedrockFullAccess
aws iam create-access-key --user-name math-iam-user
