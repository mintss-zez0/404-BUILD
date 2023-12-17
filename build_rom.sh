#!/bin/bash

set -e
set -x

# sync rom
mkdir p-404 && cd p-404
repo init -u https://github.com/P-404/android_manifest -b umai
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags


# build rom
source build/envsetup.sh;
lunch p404_sky-userdebug;
make bacon;

# upload rom
up(){
	curl --upload-file $1 https://transfer.sh/$(basename $1); echo
	# 14 days, 10 GB limit
}

up out/target/product/sky/*.zip
