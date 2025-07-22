#!/bin/bash

# Unzip the source code
sudo unzip AgentOps_src.zip

echo "Copying Config Files"
cp config/* AgentOps_src/

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

echo "Installing Python 3.9.22"

# Install dependencies for building Python
sudo yum groupinstall -y "Development Tools"
sudo yum install -y gcc openssl-devel bzip2-devel libffi-devel wget make zlib-devel

# Download and install Python 3.9.22
cd /usr/src
sudo wget https://www.python.org/ftp/python/3.9.22/Python-3.9.22.tgz
sudo tar xzf Python-3.9.22.tgz
cd Python-3.9.22
sudo ./configure --enable-optimizations
sudo make altinstall

# Create virtual environment using Python 3.9
cd ~/AgentOps_src/
python3.9 -m venv venv
source venv/bin/activate

echo "Installing Python Packages"
pip install --upgrade pip setuptools
pip install --ignore-installed -r requirements.txt

echo "Starting Backend & Frontend Servers"
uvicorn fastapi_endpoint:app --host 0.0.0.0 --port 5000 &
streamlit run streamlit_app_gpt.py --server.address=0.0.0.0 --server.port=8501 &
streamlit run streamlit_app_user_Interaction.py --server.address=0.0.0.0 --server.port=8502 &
