#
# $Id: Makefile,v 1.1 2012/07/12 00:14:10 nadya Exp $
#
# @Copyright@
# @Copyright@

ifndef ROLLCOMPILER
  ROLLCOMPILER = gnu
endif
ifndef ROLLNETWORK
  ROLLNETWORK = eth
endif
ifndef ROLLMPI
  ROLLMPI = openmpi
endif

REDHAT.ROOT = $(PWD)/../../


-include $(ROCKSROOT)/etc/Rules.mk

SOURCE = NAMD_$(VERSION)_Source

COMPILERSETUP = \
  if test -e /etc/profile.d/modules.sh; then \
    . /etc/profile.d/modules.sh; \
    module load $(ROLLCOMPILER); \
  fi

ifeq ("$(ROLLNETWORK)", "eth")
  MPIMODULE = $(ROLLMPI)
else
  MPIMODULE = $(ROLLMPI)_$(ROLLNETWORK)
endif

MPISETUP = \
  if test -e /etc/profile.d/modules.sh; then \
    . /etc/profile.d/modules.sh; \
    module load $(MPIMODULE); \
  fi; \
  export MPI_HOME=$(MPIBASE)/$(ROLLMPI)/$(ROLLCOMPILER)/$(ROLLNETWORK); \
  if test -z "$${MPI_HOME}"; then \
    export MPI_HOME=$(MPIBASE)/$(ROLLMPI); \
  fi; \
  echo Using MPI from $${MPI_HOME}; \
  export PATH=$${MPI_HOME}/bin:$${PATH}; \
  export LD_LIBRARY_PATH=$${MPI_HOME}/lib:$(CUDA)/lib64:$${LD_LIBRARY_PATH}

FCC = gfortran
#CHARMARCH = mpi-linux-x86_64-$(FCC)-mpicxx
#CHARMBUILDOPTS = mpicxx $(FCC) -j16 -O2 
CHARMARCH = mpi-linux-x86_64
CHARMBUILDOPTS = --with-production -j8 
CXX = g++
CC = gcc
CUDAOPT = --with-cuda --cuda-prefix $(CUDA)
NAMDOPT = $(CUDAOPT) --with-fftw3 --charm-arch $(CHARMARCH)

ifeq ("$(ROLLCOMPILER)", "intel")
  FCC = ifort
  CHARMARCH = mpi-linux-x86_64-$(FCC)-mpicxx
  CHARMBUILDOPTS = mpicxx $(FCC) -j16 -O2  -xHOST
  CXX = icpc        
  CC = icc
else ifeq ("$(ROLLCOMPILER)", "pgi")
  FCC = pgf90
  CHARMARCH = mpi-linux-x86_64-$(FCC)-mpicxx
  CHARMBUILDOPTS = mpicxx $(FCC) -j16 -O2  -fast
  CXX = pgCC
  CC = pgcc
endif

version.mk:
	cat version.mk.in ../version.mk > version.mk

build:
	tar zxf $(SOURCE).$(EXT)
	tar zxf tiny.tar.gz
	cd patch-files && find . -type f | grep -v CVS | cpio -pduv ../
	cd $(SOURCE) && tar xf charm-$(CHARMVER).tar
	( \
	  $(COMPILERSETUP); \
	  $(MPISETUP); \
	  cd $(SOURCE)/charm-$(CHARMVER); \
	  env MPICXX=mpicxx ./build charm++ mpi-linux-x86_64 $(CHARMBUILDOPTS); \
	  cd $(CHARMARCH)/tests/charm++/megatest; \
	  make pgm; \
	  $${MPI_HOME}/bin/mpirun -n 4 ./pgm; \
	  cd ../../../../..; \
	  ./config Linux-x86_64-$(CXX) $(NAMDOPT) ; \
	  cd Linux-x86_64-$(CXX); \
	  make -j8 \
	)

install::
	mkdir -p -m 755 $(ROOT)/$(PKGROOT)/bin
	cp $(SOURCE)/*/{charmrun,flipbinpdb,flipdcd,namd2,psfgen} \
	   $(ROOT)/$(PKGROOT)/bin
	cp -r tiny $(ROOT)/$(PKGROOT)
	mkdir -p -m 755 $(ROOT)/$(PKGROOT)/examples
	install -m 644 sge-namd*.sub $(ROOT)/$(PKGROOT)/examples/

clean::
	rm -rf $(SOURCE) tiny
	rm -rf version.mk
