# AgentFoundry-Starter-Kit

git clone this repo in aws shell

Run Ec2_creation.sh

Add IAM User names in the  setup_agent.sh script to Create agents . note down the keys & Tokens

Connect to EC2 using SSH command

sudo yum install git -y

Update the config files in config folder

Run Setup_env.sh

Access the portal on the Public IPs of EC2.

Dashboard <IP>:8501
User Interface <IP>:8502

Onboard the agents using Query Interface

Cleanup 
To delete the IAM users & tokens , Update the delete_iam_user.sh with the IAM user and run.
