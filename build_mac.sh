#!/usr/bin/env bash

# Download, mount, and copy SDL2.framework before building
curl -o SDL2.dmg https://www.libsdl.org/release/SDL2-2.0.10.dmg
hdiutil attach SDL2.dmg -mountpoint /tmp/SDL2
sudo cp -R /tmp/SDL2/SDL2.framework /Library/Frameworks/

# Download, untar, and enter SDL2_gfx source folder
curl -OL http://www.ferzkopp.net/Software/SDL2_gfx/SDL2_gfx-1.0.4.tar.gz
tar -xzf SDL2_gfx-1.0.4.tar.gz
cd SDL2_gfx-1.0.4
unzip XCode.zip

# Build SDL2_gfx
xcodebuild MACOSX_DEPLOYMENT_TARGET=10.6 -configuration Release -project XCode/SDL2_gfx/SDL2_gfx.xcodeproj

# Create a .dmg for the built SDL2_gfx framework
mkdir diskimage
cp README diskimage/ReadMe.txt
cp COPYING diskimage/License.txt
cp -R XCode/SDL2_gfx/build/Release/SDL2_gfx.framework diskimage/
rm diskimage/SDL2_gfx.framework/Modules # remove broken symlink
hdiutil create -volname SDL2_gfx -srcfolder diskimage -ov -format UDZO ../${PWD##*/}.dmg
