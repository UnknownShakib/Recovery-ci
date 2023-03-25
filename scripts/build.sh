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


# Prepare the Build Environment
source build/envsetup.sh


# export some Basic Vars
export ALLOW_MISSING_DEPENDENCIES=true


# lunch the target
lunch omni_${DEVICE}-eng || { echo "ERROR: Failed to Lunch!" && exit 1; }

# run extra command
eval "${EXTRA_CMD}"

# Build the Code
if [ -z "$J_VAL" ]; then
    mka -j$(nproc --all) $TARGET || { echo "ERROR: Failed to Build OrangeFox!" && exit 1; }
elif [ "$J_VAL"="0" ]; then
    mka $TARGET || { echo "ERROR: Failed to Build OrangeFox!" && exit 1; }
else
    mka -j${J_VAL} $TARGET || { echo "ERROR: Failed to Build OrangeFox!" && exit 1; }
fi

# Exit
exit 0
