#! /bin/bash

cd $(dirname $0)

LASTCHANGE_URL="https://www.googleapis.com/download/storage/v1/b/chromium-browser-snapshots/o/Mac%2FLAST_CHANGE?alt=media"

REVISION=$(curl -s -S $LASTCHANGE_URL)

echo "latest revision is $REVISION"

if [ -d $REVISION ] ; then
  echo "already have latest version"
  exit
fi

ZIP_URL="https://www.googleapis.com/download/storage/v1/b/chromium-browser-snapshots/o/Mac%2F$REVISION%2Fchrome-mac.zip?alt=media"

ZIP_FILE="${REVISION}-chrome-mac.zip"

echo "fetching $ZIP_URL"

rm -rf $REVISION
mkdir $REVISION
pushd $REVISION
curl -# $ZIP_URL > $ZIP_FILE
echo "unzipping.."
unzip $ZIP_FILE
popd
mv $REVISION/chrome-mac/Chromium.app/Contents/MacOS/Chromium $REVISION/chrome-mac/Chromium.app/Contents/MacOS/Chromium2
cp Chromium $REVISION/chrome-mac/Chromium.app/Contents/MacOS/Chromium
rm ./latest-Chromium.app
ln -s $REVISION/chrome-mac/Chromium.app ./latest-Chromium.app
