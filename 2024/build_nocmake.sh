## Note, toolchain was installed for all users.
## /Users/$USER/Library/Developer/Toolchains/ for local only
# TOOLCHAINLOC='/Library/Developer/Toolchains/swift-DEVELOPMENT-SNAPSHOT-2024-10-30-a.xctoolchain'

dirname=${PWD##*/} 
dirname=${dirname:-/} 
export PN="d${dirname}"

base_private_folder="/Users/$USER/Developer/AdventOfCode/AdventOfCode2024_Private"
export DATA_FOLDER=$base_private_folder/$dirname

REPOROOT=$(git rev-parse --show-toplevel)
BUILDROOT=$REPOROOT/build/$dirname
SHAREDROOT=$REPOROOT/Shared

# export TOOLCHAINS=$(plutil -extract CFBundleIdentifier raw -o - $TOOLCHAINLOC/Info.plist)
export SHARED=$SHAREDROOT

mkdir -p $BUILDROOT

# cmake -B $BUILDROOT -G Ninja .
# cmake --build $BUILDROOT

if swiftc *swift $DATA_FOLDER/realData.swift -o $BUILDROOT/$PN ; then
    cd $BUILDROOT
    ./$PN
    cd $OLDPWD
fi