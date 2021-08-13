#!/bin/sh

mkdir /tools
mkdir /build

export PATH=/tools/bin:/opt/python/cp36-cp36m/bin:${PATH}

cd /build
make -f /ci-tools/Makefile INSTALL_PREFIX=/tools
if test $? -ne 0; then exit 1; fi

cd /
tar czf /ci-tools/tools.tar.gz tools
if test $? -ne 0; then exit 1; fi

