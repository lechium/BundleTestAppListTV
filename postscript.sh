#!/bin/bash

export PATH=/usr/bin/opt/local/bin:/opt/local/sbin:/usr/local/git:$PATH
export SRCROOT="$SRCROOT"

# only used if we SCP the deb over, and this only happens if dpkg-deb and fauxsu are installed
ATV_DEVICE_IP=guest-room.local

#say "$SDKROOT"

echo $SDKROOT

BASE_SDK=`basename $SDKROOT`

if [[ $BASE_SDK == *"Simulator"* ]]
then
exit 0
fi

# xcodes path to the the full application

TARGET_BUILD_APPLICATION="$TARGET_BUILD_DIR"/"$PRODUCT_NAME".$WRAPPER_EXTENSION

echo $TARGET_BUILD_APPLICATION
# build directory for theos, we're still following his format and style as closely as possible
# this was taken from an example that was building through theos, still works tho..

DPKG_BUILD_PATH="$SRCROOT"/layout
APPLETV_APP_FOLDER="$DPKG_BUILD_PATH"/Applications

#echo $APPLETV_APP_FOLDER
# final application location in the staging directory

FINAL_APP_PATH=$APPLETV_APP_FOLDER/"$PRODUCT_NAME".$WRAPPER_EXTENSION
rm -rf "$FINAL_APP_PATH"
mkdir -p "$APPLETV_APP_FOLDER"
mkdir -p "$FINAL_APP_PATH"
cp -r "$TARGET_BUILD_APPLICATION" "$APPLETV_APP_FOLDER"
pushd "$SRCROOT"
find . -name ".DS_Store" | xargs rm -f

EXE_PATH=$FINAL_APP_PATH/$EXECUTABLE_NAME

#patches the sdk version used because apple is dumb.
#EXE_PATH2=$EXE_PATH.2
#./universalize tvos $EXE_PATH $EXE_PATH2
#mv $EXE_PATH2 $EXE_PATH
ldid -Sent.plist $EXE_PATH
rm $FINAL_APP_PATH/embedded.mobileprovision
rm -rf $FINAL_APP_PATH/_CodeSignature
/usr/local/bin/fakeroot dpkg-deb -b layout
scp layout.deb root@$ATV_DEVICE_IP:~
ssh root@$ATV_DEVICE_IP "dpkg -i layout.deb ; uicache"

exit 0


