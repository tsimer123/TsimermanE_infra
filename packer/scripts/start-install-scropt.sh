#!/bin/bash

wget https://raw.githubusercontent.com/tsimer123/TsimermanE_infra/packer-base/packer/files/start-puma.sh

wget https://raw.githubusercontent.com/tsimer123/TsimermanE_infra/packer-base/packer/files/puma.service

sudo cp puma.service /lib/systemd/system/puma.service

sudo chmod 644 /lib/systemd/system/puma.service

sudo systemctl daemon-reload

sudo systemctl enable puma.service


