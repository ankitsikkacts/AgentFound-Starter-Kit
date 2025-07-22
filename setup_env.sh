#!/bin/bash

unzip AgentOps_src.zip

echo "Downloading & Installing MongoDB"

echo "Setting up MongoDB Repository"
sudo tee /etc/yum.repos.d/mongodb-org-7.0.repo <<EOF
[mongodb-org-7.0]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/amazon/2023/mongodb-org/7.0/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://pgp.mongodb.com/server-7.0.asc
EOF

sudo yum clean all
sudo yum install -y mongodb-org

sudo systemctl start mongod

sudo systemctl enable mongod

echo "Installing Python Packages"

sudo yum install python3-pip -y
cd AgentOps_src/AgentOps_src

python3 -m pip install --upgrade setuptools[core]

python3 -m pip install --ignore-installed -r requirements.txt

uvicorn fastapi_endpoint:app --host 0.0.0.0 --port 8000 & streamlit run streamlit_app_gpt.py --server.address=0.0.0.0 --server.port=8501 & streamlit run streamlit_app_user_Interaction.py --server.address=0.0.0.0 --server.port=8502 &
