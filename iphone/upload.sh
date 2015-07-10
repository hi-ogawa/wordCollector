#!/bin/bash

# usage: upload.sh <category_name>

sleep 0.5

PICTURE=$(ls -t -d /User/Media/DCIM/100APPLE/* | head -1)

curl --data-urlencode "name=$1" -F "picture=@$PICTURE" http://often-test-app.xyz:3005/iphone_pic
