aws iam create-user --user-name test-iam-user
aws iam attach-user-policy --user-name test-iam-user --policy-arn arn:aws:iam::aws:policy/AmazonBedrockFullAccess
aws iam create-access-key --user-name test-iam-user

