## Script for automated sdl2_gfx builds via appveyor and vcpkg ##

import os
import re
from zipfile import ZipFile

archs = ['x86', 'x64']
installpath = "C:\\tools\\vcpkg\\installed\\"
portfile = "C:\\tools\\vcpkg\\ports\\sdl2-gfx\\portfile.cmake"


# Get sdl2_gfx version from vcpkg portfile

contents = open(portfile, "r").read()
version = re.findall(r"set\(VERSION ([\d\.]+)\)", contents)[0]


# Create .zip archives for the built sdl2_gfx .dlls

for arch in archs:
	
	zipname = "SDL2_gfx-{0}-win32-{1}.zip".format(version, arch)
	dll = installpath + "{0}-windows\\bin\\SDL2_gfx.dll".format(arch)
	readme = installpath + "{0}-windows\\share\\sdl2-gfx\\copyright".format(arch)
	
	with ZipFile(zipname, 'w') as z:
		z.write(dll)
		z.write(readme, 'README.txt')
		