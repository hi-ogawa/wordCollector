#!/bin/bash

# usage: upload.sh <category_name>

sleep 0.5

PICTURE=$(ls -t -d /User/Media/DCIM/100APPLE/* | head -1)
scp $PICTURE sakura:~/myapps/wordCollectorRails/public/iphone
curl --data-urlencode "name=$1" http://often-test-app.xyz:3005/iphone_pic
