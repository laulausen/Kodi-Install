#!/bin/bash

# Builds a single libretro core for testing of the build system.
# Uses special repository for game addons

# --- Define useful functions ---
compile_core () {
    echo "Compiling core $1 ..."
    num_proc=`nproc`
    echo "Using $num_proc processors"
    cd /home/kodi/kodi-source
    rm -f /home/kodi/kodi-source/tools/depends/target/binary-addons/.installed-native
    make -j$num_proc -C tools/depends/target/binary-addons PREFIX=/home/kodi/bin-kodi ADDONS="$1"
}

# --- Configure Kodi repository for Libretro cores ---
repofname="/home/kodi/kodi-source/cmake/addons/bootstrap/repositories/binary-addons.txt"
bin_addons_repo="binary-addons https://github.com/kodi-game/repo-binary-addons.git retroplayer"
rm -f $repofname
echo $bin_addons_repo >> $repofname

# --- Build the addons ---
compile_core game.libretro.genplus
