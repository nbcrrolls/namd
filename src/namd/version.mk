ifndef ROLLCOMPILER
  ROLLCOMPILER = gnu
endif
COMPILERNAME := $(firstword $(subst /, ,$(ROLLCOMPILER)))

ifndef ROLLNETWORK
  ROLLNETWORK = eth
endif

ifndef ROLLMPI
  ROLLMPI = openmpi
endif

ifndef ROLLCUDA
  ROLLCUDA = nocuda
endif

VERSION.MK.MASTER = version.mk
VERSION.MK.MASTER.DIR = ..
VERSION.MK.INCLUDE = namd.version.mk
include $(VERSION.MK.INCLUDE) 

# check if cuda exists 
ifeq ("$(ROLLCUDA)", "cuda")
  CUDAOPT = --with-cuda --cuda-prefix $(CUDAHOME)
  CUDA = -cuda
else
  CUDAOPT = --without-cuda
  CUDA = 
endif

NAME           = namd-$(COMPILERNAME)-$(ROLLNETWORK)-$(ROLLMPI)-$(ROLLCUDA)
VERSION        = $(NAMDVER)

SOURCE_NAME    = NAMD
SOURCE_SUFFIX  = tar.gz
SOURCE_VERSION = $(VERSION)
SOURCE_PKG     = $(SOURCE_NAME)_$(SOURCE_VERSION)_Source.$(SOURCE_SUFFIX)
SOURCE_DIR     = $(SOURCE_PKG:%.$(SOURCE_SUFFIX)=%)

TAR_GZ_PKGS    = $(SOURCE_PKG) 

RPM.REQUIRES    = environment-modules

