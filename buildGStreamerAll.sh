#!/bin/bash

# Copyright 2013 XMementoIT Limited (info@xmementoit.com)
# Author: Damian Ziobro (ziobro.damian@gmail.com)

#init git submodules
git submodule init 
git submodule update

#variable for color effects
textreset=$(tput sgr0) # reset the foreground colour
red=$(tput setaf 1)
green=$(tput setaf 2) 

GSTREAMER_BUILD_DIR=`pwd`

#==============================================================
# Building and installing components functions 
#==============================================================

function buildComponent {
echo -e "\n\n ${green}===> Building $1... ${textreset}\n\n"
    cd $GSTREAMER_BUILD_DIR/$1 || exit -1 
    ./autogen.sh || exit -1 
    ./configure || exit -1
    make -j`nproc` || exit -1
    echo -e "\n\n ${green}===> $1 built successfully ${textreset}\n\n"
}

function installComponent {
    echo -e "\n\n ${green}===> Installing $1 core... ${textreset}\n\n"
    cd $GSTREAMER_BUILD_DIR/$1 || exit -1
    sudo make -j10 install || exit -1
    echo -e "\n\n ${green}===> $1 installed successfully ${textreset}\n\n"
}

#==============================================================
# BUILDING  AND INSTALLING GStreamer components
#==============================================================

# GSTREAMER CORE
buildComponent gstreamer || exit -1
installComponent gstreamer || exit -1

# GSTREAMER PLUGINS BASE
buildComponent gst-plugins-base || exit -1
installComponent gst-plugins-base || exit -1

# GSTREAMER PLUGINS BAD
buildComponent gst-plugins-bad || exit -1
installComponent gst-plugins-bad || exit -1

# GSTREAMER PLUGINS GOOD
buildComponent gst-plugins-good || exit -1
installComponent gst-plugins-good || exit -1

# GSTREAMER PLUGINS UNGLY
buildComponent gst-plugins-ugly || exit -1
installComponent gst-plugins-ugly || exit -1

# GSTREAMER RTSP SERVER
buildComponent gst-rtsp-server || exit -1
installComponent gst-rtsp-server || exit -1

