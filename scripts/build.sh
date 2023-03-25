#!/bin/bash

# Source Configs
source $CONFIG

# Change to the Source Directry
cd ~



# Set-up ccache
if [ -z "$CCACHE_SIZE" ]; then
    ccache -M 10G
else
    ccache -M ${CCACHE_SIZE}
fi

# Initialize the latest stable branch
$ repo init -u https://github.com/PitchBlackRecoveryProject/manifest_pb -b android-12.1

# Sync the latest stable branch
$ repo sync

# Prepare the Build Environment
source build/envsetup.sh


# export some Basic Vars
export ALLOW_MISSING_DEPENDENCIES=true


# lunch the target
lunch omni_${DEVICE}-eng
    
# Build the Code

mka -j$(nproc --all) $TARGET


# Exit
exit 0
