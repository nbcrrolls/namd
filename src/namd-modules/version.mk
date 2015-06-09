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

# check if need to add cuda module
ifeq ("$(ROLLCUDA)", "cuda")
  CUDA = -cuda
  ADDCUDA = cuda
else
  ADDCUDA =
endif

# define dependent modules that will need to be loaded  with namd module
ADDCOMP = 
ifeq ("$(ROLLCOMPILER)", "intel")
  ADDCOMP = intel mkl
endif

PREREQMODULES = "$(ROLLMPI)-$(COMPILERNAME)-$(ROLLNETWORK) $(ADDCUDA) $(ADDCOMP)"

VERSION.MK.MASTER = version.mk
VERSION.MK.MASTER.DIR = ..
VERSION.MK.INCLUDE = namd.version.mk
include $(VERSION.MK.INCLUDE) 

PACKAGE     = namd
CATEGORY    = applications
NAME        = namd-module-$(COMPILERNAME)-$(ROLLNETWORK)-$(ROLLMPI)-$(ROLLCUDA)
VERSION     = $(NAMDVER)
RELEASE     = 0
PKGROOT     = /opt/modulefiles/$(CATEGORY)/$(PACKAGE)$(VERSION)

RPM.REQUIRES    = environment-modules

