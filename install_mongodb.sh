#!/bin/bash
curl -fsSL https://www.mongodb.org/static/pgp/server-3.2.asc | sudo apt-key add -
echo  "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /e$
sudo apt update
sudo apt install -y mongodb-org
sudo systemctl start mongod
sudo systemctl enable mongod
sudo systemctl status mongod
