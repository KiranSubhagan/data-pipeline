#!/bin/bash
set -e
rm -rf package lambda.zip
mkdir package
pip install -r requirements.txt -t package
cp app.py package/
cd package
zip -r ../lambda.zip .
