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

VERSION.MK.MASTER = version.mk
VERSION.MK.MASTER.DIR = ..
VERSION.MK.INCLUDE = namd.version.mk
include $(VERSION.MK.INCLUDE) 

# check if cuda exists 
CUDAOPT = --without-cuda
HAVECUDA =
CUDA = 
CUDA = $(shell if [ -x $(CUDAHOME) ]; then echo cuda ; fi;)
ifneq ("$(CUDA)", "")
  CUDAOPT = --with-cuda --cuda-prefix $(CUDAHOME)
  HAVECUDA = -$(CUDA)
endif

NAME           = namd-$(COMPILERNAME)$(HAVECUDA)
VERSION        = $(NAMDVER)

SOURCE_NAME    = NAMD
SOURCE_SUFFIX  = tar.gz
SOURCE_VERSION = $(VERSION)
SOURCE_PKG     = $(SOURCE_NAME)_$(SOURCE_VERSION)_Source.$(SOURCE_SUFFIX)
SOURCE_DIR     = $(SOURCE_PKG:%.$(SOURCE_SUFFIX)=%)

TINY_NAME      = tiny
TINY_SUFFIX    = tar.gz
TINY_PKG       = $(TINY_NAME).$(TINY_SUFFIX)
TINY_DIR       = $(TINY_PKG:%.$(TINY_SUFFIX)=%)

#TCL_NAME       = tcl
#TCL_SUFFIX     = tar.gz
#TCL_VERSION    = 8.6.3
#TCL_PKG        = $(TCL_NAME)$(TCL_VERSION)-linux-$(ARCH).$(TCL_SUFFIX)
#TCL_DIR        = $(TCL_PKG:%.$(TCL_SUFFIX)=%)

#TCL_NAME_THREADED       = tcl-threaded
#TCL_SUFFIX_THREADED     = tar.gz
#TCL_VERSION_THREADED    = 8.5.9
#TCL_PKG_THREADED        = $(TCL_NAME)$(TCL_VERSION_THREADED)-linux-$(ARCH)-threaded.$(TCL_SUFFIX_THREADED)
#TCL_DIR_THREADED        = $(TCL_PKG_THREADED:%.$(TCL_SUFFIX_THREADED)=%)

#FFTW_NAME      = fftw-linux
#FFTW_SUFFIX    = tar.gz
#FFTW_VERSION   = $(ARCH)
#FFTW_PKG       = $(FFTW_NAME)-$(ARCH).$(FFTW_SUFFIX)
#FFTW_DIR       = linux-$(ARCH)

#TAR_GZ_PKGS    = $(SOURCE_PKG) $(TINY_PKG) $(TCL_PKG) $(TCL_PKG_THREADED) $(FFTW_PKG)
TAR_GZ_PKGS    = $(SOURCE_PKG) $(TINY_PKG) 

RPM.REQUIRES    = environment-modules

