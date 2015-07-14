#!/bin/bash

# usage: upload.sh <category_name> <basic_auth_user> <basic_auth_pass>
# e.g. upload.sh iphone hiroshi ogawa

sleep 0.5

PICTURE=$(ls -t -d /User/Media/DCIM/100APPLE/* | head -1)
scp $PICTURE sakura:~/myapps/wordCollectorRails/public/iphone
curl --data-urlencode "name=$1" --user $2:$3 http://often-test-app.xyz:3005/iphone_pic

# http://stackoverflow.com/questions/3044315/how-to-set-the-authorization-header-using-curl
# http://stackoverflow.com/questions/2853803/in-a-shell-script-echo-shell-commands-as-they-are-executed
