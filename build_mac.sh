#!/usr/bin/env bash

curl -o SDL2.dmg https://www.libsdl.org/release/SDL2-2.0.10.dmg
hdiutil attach SDL2.dmg -mountpoint /tmp/SDL2
cp -R /tmp/SDL2/SDL2.framework /Library/Frameworks/

curl -OL http://www.ferzkopp.net/Software/SDL2_gfx/SDL2_gfx-1.0.4.tar.gz
tar -xzf SDL2_gfx-1.0.4.tar.gz
cd SDL2_gfx-1.0.4
unzip XCode.zip
xcodebuild MACOSX_DEPLOYMENT_TARGET=10.6 -configuration Release -project XCode/SDL2_gfx/SDL2_gfx.xcodeproj
mkdir diskimage
cp README diskimage/ReadMe.txt
cp COPYING diskimage/License.txt
cp -R XCode/SDL2_gfx/build/Release/SDL2_gfx.framework diskimage/
hdiutil create -volname SDL2_gfx -srcfolder diskimage -ov -format UDZO ../${PWD##*/}.dmg
