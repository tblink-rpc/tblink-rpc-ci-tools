
VERILATOR_VERSION=

ifeq (,$(BUILD_DIR))
  BUILD_DIR := $(shell pwd)
endif

WGET=wget

ifeq (,$(INSTALL_PREFIX))
INSTALL_PREFIX=$(BUILD_DIR)/install
endif

CONFIGURE_OPTS += --prefix=$(INSTALL_PREFIX)

PATH := $(INSTALL_PREFIX)/bin:$(PATH)
export PATH

PACKAGES_DIR=$(BUILD_DIR)/packages

BOOLECTOR_VERSION=3.2.2
BOOLECTOR_DIR=boolector-$(BOOLECTOR_VERSION)
BOOLECTOR_URL=https://github.com/Boolector/boolector/archive/refs/tags/$(BOOLECTOR_VERSION).tar.gz
BOOLECTOR_TGZ=$(PACKAGES_DIR)/$(BOOLECTOR_DIR).tar.gz

CMAKE_VERSION=3.20.4
CMAKE_DIR=cmake-$(CMAKE_VERSION)
CMAKE_TGZ=$(PACKAGES_DIR)/$(CMAKE_DIR).tar.gz
CMAKE_URL=https://github.com/Kitware/CMake/releases/download/v$(CMAKE_VERSION)/$(CMAKE_DIR).tar.gz

ICARUS_VERSION=11_0
ICARUS_DIR=iverilog-$(ICARUS_VERSION)
ICARUS_URL=https://github.com/steveicarus/iverilog/archive/refs/tags/v$(ICARUS_VERSION).tar.gz
ICARUS_TGZ=$(PACKAGES_DIR)/$(ICARUS_DIR).tar.gz

SBY_DIR=SymbiYosys-master
SBY_URL=https://github.com/YosysHQ/SymbiYosys/archive/refs/heads/master.zip
SBY_ZIP=$(PACKAGES_DIR)/$(SBY_DIR).zip

VERILATOR_VERSION=4.204
VERILATOR_DIR=verilator-$(VERILATOR_VERSION)
VERILATOR_URL=https://github.com/verilator/verilator/archive/refs/tags/v$(VERILATOR_VERSION).tar.gz
VERILATOR_TGZ=$(PACKAGES_DIR)/$(VERILATOR_DIR).tar.gz

YOSYS_DIR=yosys-master
YOSYS_ZIP=$(PACKAGES_DIR)/$(YOSYS_DIR).zip
YOSYS_URL=https://github.com/YosysHQ/yosys/archive/refs/heads/master.zip

#PACKAGES += $(BUILD_DIR)/cmake.build
PACKAGES += $(BUILD_DIR)/icarus.build
PACKAGES += $(BUILD_DIR)/sby.build
PACKAGES += $(BUILD_DIR)/verilator.build

all : $(PACKAGES)

#********************************************************************
#* Boolector
#********************************************************************
$(BUILD_DIR)/boolector.build : $(BOOLECTOR_TGZ)
	rm -rf $(BUILD_DIR)/boolector_tmp
	mkdir -p $(BUILD_DIR)/boolector_tmp
	cd $(BUILD_DIR)/boolector_tmp ; tar xvzf $(BOOLECTOR_TGZ)
	cd $(BUILD_DIR)/boolector_tmp/$(BOOLECTOR_DIR) ; ./contrib/setup-btor2tools.sh
	cd $(BUILD_DIR)/boolector_tmp/$(BOOLECTOR_DIR) ; ./contrib/setup-lingeling.sh
	cd $(BUILD_DIR)/boolector_tmp/$(BOOLECTOR_DIR) ; ./contrib/setup-cadical.sh
	cd $(BUILD_DIR)/boolector_tmp/$(BOOLECTOR_DIR) ; \
		./configure.sh --shared --prefix $(INSTALL_PREFIX)
	cd $(BUILD_DIR)/boolector_tmp/$(BOOLECTOR_DIR)/build ; $(MAKE)
	cd $(BUILD_DIR)/boolector_tmp/$(BOOLECTOR_DIR)/build ; $(MAKE) install
	touch $@

$(BOOLECTOR_TGZ) : 
	mkdir -p `dirname $@`
	$(WGET) -O $@ $(BOOLECTOR_URL)

#********************************************************************
#* Cmake
#********************************************************************

$(BUILD_DIR)/cmake.build : $(CMAKE_TGZ)
	echo "CMAKE_TGZ: $(CMAKE_TGZ)"
	rm -rf $(BUILD_DIR)/cmake_tmp
	mkdir -p $(BUILD_DIR)/cmake_tmp
	cd $(BUILD_DIR)/cmake_tmp ; tar xvzf $(CMAKE_TGZ)
	cd $(BUILD_DIR)/cmake_tmp/$(CMAKE_DIR) ; ./configure --prefix=$(INSTALL_PREFIX)
	cd $(BUILD_DIR)/cmake_tmp/$(CMAKE_DIR) ; $(MAKE)
	cd $(BUILD_DIR)/cmake_tmp/$(CMAKE_DIR) ; $(MAKE) install
	which cmake
	touch $@


$(CMAKE_TGZ) : 
	mkdir -p `dirname $@`
	$(WGET) -O $@ $(CMAKE_URL)

#********************************************************************
#* Icarus Verilog
#********************************************************************
$(BUILD_DIR)/icarus.build : $(ICARUS_TGZ)
	rm -rf $(BUILD_DIR)/icarus_tmp
	mkdir -p $(BUILD_DIR)/icarus_tmp
	cd $(BUILD_DIR)/icarus_tmp ; tar xvzf $(ICARUS_TGZ)
	cd $(BUILD_DIR)/icarus_tmp/$(ICARUS_DIR) ; /bin/bash ./autoconf.sh
	cd $(BUILD_DIR)/icarus_tmp/$(ICARUS_DIR) ; ./configure $(CONFIGURE_OPTS)
	cd $(BUILD_DIR)/icarus_tmp/$(ICARUS_DIR) ; $(MAKE)
	cd $(BUILD_DIR)/icarus_tmp/$(ICARUS_DIR) ; $(MAKE) install
	rm -rf $(BUILD_DIR)/icarus_tmp
	touch $@

$(ICARUS_TGZ) :
	mkdir -p `dirname $@`
	$(WGET) -O $@ $(ICARUS_URL)

#********************************************************************
#* SBY
#********************************************************************
$(BUILD_DIR)/sby.build : $(SBY_ZIP) $(BUILD_DIR)/boolector.build $(BUILD_DIR)/yosys.build
	rm -rf $(BUILD_DIR)/sby_tmp
	mkdir -p $(BUILD_DIR)/sby_tmp
	cd $(BUILD_DIR)/sby_tmp ; unzip $(SBY_ZIP)
	cd $(BUILD_DIR)/sby_tmp/$(SBY_DIR) ; $(MAKE) PREFIX=$(INSTALL_PREFIX)
	cd $(BUILD_DIR)/sby_tmp/$(SBY_DIR) ; $(MAKE) PREFIX=$(INSTALL_PREFIX) install
	touch $@

$(SBY_ZIP) :
	mkdir -p `dirname $@`
	$(WGET) -O $@ $(SBY_URL)

#********************************************************************
#* Verilator
#********************************************************************
$(BUILD_DIR)/verilator.build : $(VERILATOR_TGZ)
	rm -rf $(BUILD_DIR)/verilator_tmp
	mkdir -p $(BUILD_DIR)/verilator_tmp
	cd $(BUILD_DIR)/verilator_tmp ; tar xvzf $(VERILATOR_TGZ)
	cd $(BUILD_DIR)/verilator_tmp/$(VERILATOR_DIR) ; autoconf
	cd $(BUILD_DIR)/verilator_tmp/$(VERILATOR_DIR) ; ./configure $(CONFIGURE_OPTS)
	cd $(BUILD_DIR)/verilator_tmp/$(VERILATOR_DIR) ; $(MAKE)
	cd $(BUILD_DIR)/verilator_tmp/$(VERILATOR_DIR) ; $(MAKE) install
	rm -rf $(BUILD_DIR)/verilator_tmp
	touch $@

$(VERILATOR_TGZ) :
	mkdir -p `dirname $@`
	$(WGET) -O $@ $(VERILATOR_URL)

#********************************************************************
#* Yosys
#********************************************************************

$(BUILD_DIR)/yosys.build : $(YOSYS_ZIP)
	rm -rf $(BUILD_DIR)/yosys_tmp
	mkdir -p $(BUILD_DIR)/yosys_tmp
	cd $(BUILD_DIR)/yosys_tmp ; unzip $(YOSYS_ZIP)
	cd $(BUILD_DIR)/yosys_tmp/$(YOSYS_DIR) ; $(MAKE) PREFIX=$(INSTALL_PREFIX)
	cd $(BUILD_DIR)/yosys_tmp/$(YOSYS_DIR) ; $(MAKE) PREFIX=$(INSTALL_PREFIX) install
	touch $@

$(YOSYS_ZIP) :
	mkdir -p `dirname $@`
	$(WGET) -O $@ $(YOSYS_URL)

