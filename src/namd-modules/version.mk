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

# define dependent modules that will need to be loaded  with namd module
ADDCOMP = 
ifeq ("$(ROLLCOMPILER)", "intel")
  ADDCOMP = intel mkl
endif
PREREQMODULES = "$(ROLLMPI)-$(COMPILERNAME)-$(ROLLNETWORK) $(CUDA) $(ADDCOMP)"

VERSION.MK.MASTER = version.mk
VERSION.MK.MASTER.DIR = ..
VERSION.MK.INCLUDE = namd.version.mk
include $(VERSION.MK.INCLUDE) 

PACKAGE     = namd
CATEGORY    = applications
NAME        = namd-module-$(COMPILERNAME)-$(ROLLNETWORK)-$(ROLLMPI)
RELEASE     = 0
PKGROOT     = /opt/modulefiles/$(CATEGORY)/$(PACKAGE)$(VERSION)

RPM.REQUIRES    = environment-modules

