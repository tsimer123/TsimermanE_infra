#!/bin/bash

cd /home/appuser/reddit
puma -d
ps aux | grep puma
