#!/bin/bash

# Variables
KEY_NAME="DemoKeyPair"
SECURITY_GROUP_NAME="DemoSecurityGroup"
INSTANCE_NAME="DemoInstance"
AMI_ID="ami-0150ccaf51ab55a51"  # Replace with a valid AMI ID for your region
INSTANCE_TYPE="t2.large"
REGION="us-east-1"

# Create a key pair and save the private key
aws ec2 delete-key-pair --key-name $KEY_NAME

aws ec2 create-key-pair --key-name $KEY_NAME --query 'KeyMaterial' --output text | tee DemoKeyPair.tmp
sudo cp DemoKeyPair.tmp DemoKeyPair.pem
chmod 400 DemoKeyPair.pem

echo "Key pair created and saved to ${KEY_NAME}.pem"

# Create a security group
SECURITY_GROUP_ID=$(aws ec2 create-security-group --group-name $SECURITY_GROUP_NAME --description "Security group for EC2 instance" --region $REGION --query 'GroupId' --output text)
echo "Security group created with ID: $SECURITY_GROUP_ID"

# Add rules to allow access
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --protocol tcp --port 22 --cidr 0.0.0.0/0 --region $REGION
echo "SSH access enabled for security group"

aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --protocol tcp --port 80 --cidr 0.0.0.0/0 --region $REGION
echo "HTTP access enabled for security group"

aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --protocol tcp --port 443 --cidr 0.0.0.0/0 --region $REGION
echo "HTTPS access enabled for security group"

# Add custom ports for your services
for PORT in 8000 8501; do
  aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --protocol tcp --port $PORT --cidr 0.0.0.0/0 --region $REGION
  echo "Custom TCP port $PORT access enabled for security group"
done

# Launch the EC2 instance
INSTANCE_ID=$(aws ec2 run-instances \
    --image-id $AMI_ID \
    --count 1 \
    --instance-type $INSTANCE_TYPE \
    --key-name $KEY_NAME \
    --security-group-ids $SECURITY_GROUP_ID \
    --region $REGION \
    --query 'Instances[0].InstanceId' \
    --output text)

echo "EC2 instance launched with ID: $INSTANCE_ID"

# Tag the instance
aws ec2 create-tags --resources $INSTANCE_ID --tags Key=Name,Value=$INSTANCE_NAME --region $REGION
echo "Instance tagged with Name: $INSTANCE_NAME"
