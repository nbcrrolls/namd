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
  CUDAEXT = _cuda
else
  ADDCUDA =
  CUDAEXT = 
endif

VERSION.MK.MASTER = version.mk
VERSION.MK.MASTER.DIR = ..
VERSION.MK.INCLUDE = namd.version.mk
include $(VERSION.MK.INCLUDE)

NAME    = namd-opal-$(COMPILERNAME)-$(ROLLNETWORK)-$(ROLLMPI)-$(ROLLCUDA)
VERSION = 1.0

