#!/bin/bash

FROM="/Users/hiogawa/repositories/github_public/wordCollector/wordCollectorRails/"
TO="sakura:~/myapps/wordCollectorRails/"

rsync -av $FROM $TO --exclude-from="$FROM/.rsync_exclude" --delete-before
