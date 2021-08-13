FROM quay.io/pypa/manylinux2010_x86_64:latest

#RUN yum group install -y "Development Tools"
#RUN dnf -y install dnf-plugins-core
#RUN dnf -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
#RUN dnf config-manager --set-enabled powertools
RUN yum install -y wget gperf bzip2-devel \
    bison flex xz-devel openssl-devel
RUN yum install -y tcl-devel tk-devel readline-devel \
    libffi-devel 


#********************************************************************
#* Build and install Icarus
#********************************************************************
#RUN make BUILD_DIR=/build INSTALL_GLOBAL=true -f /dv-tools/Makefile /build/cmake.build ; \
#    rm -rf /build ; which cmake
#RUN make BUILD_DIR=/build INSTALL_GLOBAL=true -f /dv-tools/Makefile /build/verilator.build ; \
#    rm -rf /build
#RUN make BUILD_DIR=/build INSTALL_GLOBAL=true -f /dv-tools/Makefile /build/icarus.build ; \
#    rm -rf /build
#RUN dnf install -y readline-devel libffi-devel
#RUN make BUILD_DIR=/build INSTALL_GLOBAL=true -f /dv-tools/Makefile /build/sby.build ; \
#    rm -rf /build
   


