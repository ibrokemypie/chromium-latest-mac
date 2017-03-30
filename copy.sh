#! /bin/bash

BASEDIR=$(dirname $0)

rm -rf /Applications/Chromium.app

latest=$(ls -1 -d */ | sort -rnk3 | awk '!x[$2]++')
echo $latest
cp -r $BASEDIR"/"$latest"chrome-mac/Chromium.app" /Applications/Chromium.app
