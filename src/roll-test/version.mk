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

NAME       = namd-roll-test
VERSION    = $(NAMDVER)
RELEASE    = 0
PKGROOT    = /opt/namd$(NAMDVER)

TINY_NAME      = tiny
TINY_SUFFIX    = tar.gz
TINY_PKG       = $(TINY_NAME).$(TINY_SUFFIX)
TINY_DIR       = $(TINY_PKG:%.$(TINY_SUFFIX)=%)
TAR_GZ_PKGS    = $(SOURCE_PKG) $(TINY_PKG)

RPM.REQUIRES    = environment-modules
RPM.EXTRAS = AutoReq:No
