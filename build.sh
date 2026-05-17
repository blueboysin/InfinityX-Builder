#!/bin/bash

# Prepare clean building folders
mkdir -p ~/android
cd ~/android

# Configure Git identities
git config --global user.name "blueboysin"
git config --global user.email "blueboysin@github.com"

# Pull Project Infinity-X 3.10 Android 16 code base
repo init -u https://github.com/projectinfinity-x/manifest.git -b 16 --git-lfs --depth=1 --no-repo-verify

# Copy your custom munch map into the main system
mkdir -p .repo/local_manifests
cp /tmp/munch.xml .repo/local_manifests/munch.xml

# Download everything cleanly (Corrected command below)
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags

# Set up terminal compilation commands
. build/envsetup.sh

# Select POCO F4 as our target phone
lunch infinity_munch-userdebug

# Bake the ROM!
mka bacon -j$(nproc --all)
