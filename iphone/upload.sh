#!/bin/bash

sleep 0.5

PICTURE=$(ls -t -d /User/Media/DCIM/100APPLE/* | head -1)

curl -F "picture=@$PICTURE" http://often-test-app.xyz:3005/posts/iphone3
