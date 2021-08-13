#!/bin/sh

cwd=`pwd`

cd $cwd/ci-tools

if test ! -f iverilog-11_0.tar.gz; then
	wget -O iverilog-11_0.tar.gz https://github.com/steveicarus/iverilog/archive/refs/tags/v11_0.tar.gz
	tar xvzf iverilog-11_0.tar.gz
        cd iverilog-11_0
	/bin/sh autoconf
	cd ..
	tar czf iverilog-11_0.tar.gz iverilog-11_0
fi

if test ! -f verilator-4.204.tar.gz; then
	wget -O verilator-4.204.tar.gz https://github.com/verilator/verilator/archive/refs/tags/v4.204.tar.gz
	tar xvzf verilator-4.204.tar.gz
	cd verilator-4.204
	/bin/sh autoconf
	cd ..
	tar czf verilator-4.204.tar.gz verilator-4.204
fi

cd $cwd

docker build -t tblink-rpc-ci-tools-build ci-tools-build
if test $? -ne 0; then exit 1; fi 

#docker run -v `pwd`/ci-tools:/ci-tools tblink-rpc-ci-tools-build /ci-tools/build.sh
#if test $? -ne 0; then exit 1; fi

#docker build --no-cache -t fw-dv-tools -v `pwd`/dv-tools:/dv-tools dv-tools
docker build -t tblink-rpc-ci-tools -v `pwd`/ci-tools:/ci-tools ci-tools
if test $? -ne 0; then exit 1; fi

