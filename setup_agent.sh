aws iam create-user --user-name agent-iam-user
aws iam attach-user-policy --user-name agent-iam-user --policy-arn arn:aws:iam::aws:policy/AmazonBedrockFullAccess
aws iam create-access-key --user-name agent-iam-user

aws iam create-user --user-name math-iam-user
aws iam attach-user-policy --user-name math-iam-user --policy-arn arn:aws:iam::aws:policy/AmazonBedrockFullAccess
aws iam create-access-key --user-name math-iam-user
