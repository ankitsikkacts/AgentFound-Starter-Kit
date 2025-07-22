#!/bin/bash

USER_NAMES=("agent-iam-user" "math-iam-user")
POLICY_ARN="arn:aws:iam::aws:policy/AmazonBedrockFullAccess"
LOG_FILE="delete_iam_user.log"

echo "Starting IAM user deletion process..." | tee $LOG_FILE

for USER_NAME in "${USER_NAMES[@]}"; do
    echo "Processing IAM user: $USER_NAME" | tee -a $LOG_FILE

    # Step 1: List and delete all access keys
    echo "Listing access keys for $USER_NAME..." | tee -a $LOG_FILE
    ACCESS_KEYS=$(aws iam list-access-keys --user-name "$USER_NAME" --query 'AccessKeyMetadata[*].AccessKeyId' --output text)

    for KEY in $ACCESS_KEYS; do
        echo "Deleting access key $KEY for $USER_NAME..." | tee -a $LOG_FILE
        aws iam delete-access-key --user-name "$USER_NAME" --access-key-id "$KEY" >> $LOG_FILE 2>&1
        if [ $? -ne 0 ]; then
            echo "Failed to delete access key $KEY" | tee -a $LOG_FILE
        fi
    done

    # Step 2: Detach policy
    echo "Detaching policy $POLICY_ARN from $USER_NAME..." | tee -a $LOG_FILE
    aws iam detach-user-policy --user-name "$USER_NAME" --policy-arn "$POLICY_ARN" >> $LOG_FILE 2>&1
    if [ $? -ne 0 ]; then
        echo "Failed to detach policy $POLICY_ARN" | tee -a $LOG_FILE
    fi

    # Step 3: Delete user
    echo "Deleting IAM user $USER_NAME..." | tee -a $LOG_FILE
    aws iam delete-user --user-name "$USER_NAME" >> $LOG_FILE 2>&1
    if [ $? -ne 0 ]; then
        echo "Failed to delete user $USER_NAME" | tee -a $LOG_FILE
    else
        echo "Successfully deleted IAM user $USER_NAME" | tee -a $LOG_FILE
    fi

    echo "----------------------------------------" | tee -a $LOG_FILE
done

echo "IAM user deletion process completed." | tee -a $LOG_FILE
