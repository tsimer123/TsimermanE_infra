#! /bin/bash
cd /home/appuser/
ls -la
pwd
git clone -b cloud-testapp  https://github.com/tsimer123/TsimermanE_infra.git
chown -R appuser:appuser /home/appuser/TsimermanE_infra
sudo -u appuser /home/appuser/TsimermanE_infra/install_ruby.sh
sudo -u appuser /home/appuser/TsimermanE_infra/install_mongodb.sh
sudo -u appuser /home/appuser/TsimermanE_infra/deploy.sh
