#!/bin/bash
echo git clone -b monolith https://github.com/express42/reddit.git
echo cd reddit &&  bundle install
echo puma -d
echo ps aux > grep puma
