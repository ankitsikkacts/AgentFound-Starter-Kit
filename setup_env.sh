#!/bin/bash

# Unzip the source code
sudo unzip AgentOps_src.zip

echo "Copying Config Files"
sudo cp Config/* AgentOps_src
sudo cp Config/* AgentOps_src/pages

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

# Create virtual environment using Python 3.9
sudo chmod 777 AgentOps_src
cd AgentOps_src
python3.9 -m venv .venv
source .venv/bin/activate

echo "Installing Python Packages"
python3.9 -m pip install --upgrade pip setuptools
python3.9 -m pip install -r requirements.txt

python3.9 -m unittest test_database_connection.py

echo "Starting Backend & Frontend Servers"
uvicorn fastapi_endpoint:app --host 0.0.0.0 --port 5000 & streamlit run Streamlit_UI.py --server.address=0.0.0.0 --server.port=8501 &
