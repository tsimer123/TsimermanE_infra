#!/bin/bash
echo curl -fsSL https://www.mongodb.org/static/pgp/server-3.2.asc | sudo apt-key add -
echo echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" > sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
echo sudo apt update
echo sudo apt install -y mongodb-org
echo sudo systemctl start mongod
echo sudo systemctl enable mongod
