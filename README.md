# AgentFondry Monitoring Starter Kit

Welcome to the AgentFoundry Starter Kit! This guide will help you quickly set up and deploy AgentFoundry on AWS. Follow these simple steps to get your agent environment up and running.

## Quick Start Guide

### Step 1: Clone the Repository
Clone this repository to your AWS Cloud Shell:

```bash
git clone https://github.com/ankitsikkacts/AgentFound-Starter-Kit.git
cd AgentFound-Starter-Kit
```

### Step 2: Create EC2 Infrastructure
Run the EC2 creation script to set up your infrastructure:

```bash
sh create_ec2_instance.sh
```

### Step 3: Configure Your Agents
Open the `setup_agent.sh` script and add your desired IAM user names. This script will create the necessary agents and generate authentication tokens.

```bash
nano setup_agent.sh
# Add your IAM usernames where indicated
sh setup_agent.sh > agent.log
```

> **Important:** Make sure to note down the generated access keys and tokens - you'll need these later!

### Step 4: Connect to Your EC2 Instance
Use SSH to connect to your newly created EC2 instance:

```bash
ssh -i your-key-pair.pem ec2-user@your-instance-public-ip
```

### Step 5: Install Git on EC2
Install Git on your EC2 instance:

```bash
sudo yum install git -y
```

### Step 6: Clone the Repository on EC2
Clone the repository on your EC2 instance to get all the necessary files:

```bash
git clone https://github.com/ankitsikkacts/AgentFound-Starter-Kit.git
cd AgentFound-Starter-Kit
```

### Step 7: Update Configuration Files
Navigate to the config folder and update the configuration files with your settings:

```bash
cd Config
# Edit the necessary configuration files
nano config_agent.json
nano config_server.json
```

### Step 8: Setup the Environment
Run the environment setup script:
cd ..
```bash
sh setup_env.sh

```

### Step 9: Access the AgentFoundry Portal
Once setup is complete, you can access the AgentFoundry interfaces using your EC2 instance's public IP:

- **Dashboard:** `http://your-instance-public-ip:8501`
- **User Interface:** `http://your-instance-public-ip:8502`

### Step 10: Onboard Your Agents
Use the Query Interface to onboard your agents. Follow the on-screen instructions to complete the process.

## Cleaning Up Resources

When you're done with your AgentFoundry environment, you can clean up the created IAM users and tokens:

```bash
# Edit the delete_iam_user.sh script with the IAM users you want to delete
nano delete_iam_user.sh
# Run the script
sh delete_iam_user.sh
```

## Troubleshooting

If you encounter any issues during setup, check the following:
- Ensure your AWS credentials have sufficient permissions
- Verify that all configuration files contain the correct information
- Check EC2 instance security groups allow traffic on ports 8501 and 8502

## Need Help?

If you need assistance, please open an issue in this repository or contact our support team.

---

Happy agent monitoring with AgentFondry Monitoring!
