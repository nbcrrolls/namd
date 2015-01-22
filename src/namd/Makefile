#
# $Id: Makefile,v 1.1 2012/07/12 00:14:10 nadya Exp $
#
# @Copyright@
# @Copyright@

REDHAT.ROOT = $(PWD)/../../

-include $(ROCKSROOT)/etc/Rules.mk
include Rules.mk
include $(NBCRDEVEL)/NBCR.mk

# charm options 
CC = gcc
CXX = g++
FCC = gfortran

CHARMARCH = mpi-linux-x86_64
CHARMBUILDOPTS = -no-build-shared -DCMK_OPTIMIZE
CHARMBUILDOPTS =  --with-production -j8
ifeq ("$(COMPILERNAME)", "intel")
  CC = icc
  CXX = icpc
  FCC = ifort
  CHARMARCH = mpi-linux-x86_64-$(FCC)-mpicxx
  CHARMBUILDOPTS = mpicxx $(FCC) -j16 -O2  -xHOST
else ifeq ("$(COMPILERNAME)", "pgi")
  CC = pgcc
  CXX = pgCC
  FCC = pgf90
  CHARMARCH = mpi-linux-x86_64-$(FCC)-mpicxx
  CHARMBUILDOPTS = mpicxx $(FCC) -j16 -O2  -fast
endif

ifneq ("$(ROLLOPTS)", "$(subst avx,,$(ROLLOPTS))")
  ifeq ("$(COMPILERNAME)", "gnu")
    CHARMBUILDOPTS += -mavx
    COMPILE_FLAGS += -mavx
  endif
endif

# commands for running CHARM compile test
CHARMTEST = \
  cd $(CHARMARCH)/tests/charm++/megatest; \
  make pgm; \
  mpirun -n 4 ./pgm; \
  cd ../../../..

# exampel sge submit file for namd jobs
EXFILES = sge-namd.sub sge-namd-cuda.sub

# need this MPI module to load environment
MPIMODULE = $(ROLLMPI)-$(ROLLCOMPILER)-$(ROLLNETWORK)

ADDSED = \
	-e s%@PREREQMODULES@%$(PREREQMODULES)%g  \
	-e s%@COMPILERNAME@%$(COMPILERNAME)%g  \
	-e s%@ROLLNETWORK@%$(ROLLNETWORK)%g

%: %.in
	$(SED) $(SEDSCRIPT) $(ADDSED) $^ > $@

pretar:: $(VERSION.MK.INCLUDE)

$(VERSION.MK.INCLUDE): 
	if [ -f $(VERSION.MK.MASTER.DIR)/$(VERSION.MK.MASTER) ]; then \
	    /bin/cp $(VERSION.MK.MASTER.DIR)/$(VERSION.MK.MASTER) $@; \
	fi

build: $(SRC_DIRS) $(EXFILES)
	(cd patch-files && find . -type f | grep -v CVS | cpio -pduv ../)
	cd $(SOURCE_DIR) && tar xf charm-$(CHARMVER).tar
	( \
	  $(MODULE_LOAD_CC); \
	  $(MODULE_LOAD_MPI); \
	  if test -e $(CUDAHOME); then \
	    $(MODULE_LOAD_CUDA); \
	  fi; \
	  cd $(SOURCE_DIR)/charm-$(CHARMVER); \
	  ./build charm++ mpi-linux-x86_64 $(CHARMBUILDOPTS); \
	  $(CHARMTEST); \
	  cd ..; \
	  ./config Linux-x86_64-MPI-$(CC) \
		--charm-arch $(CHARMARCH) \
		--fftw-prefix $(PKGROOT)  \
		--tcl-prefix $(PKGROOT)   \
		$(CUDAOPT); \
	  cd Linux-x86_64-MPI-$(CC); \
	  make -j 16 \
	)

install::
	mkdir -p -m 755 $(ROOT)/$(PKGROOT)/bin
	cp $(SOURCE_DIR)/*/{charmrun,flipbinpdb,flipdcd,namd2,psfgen} \
	   $(ROOT)/$(PKGROOT)/bin
	cp -r tiny $(ROOT)/$(PKGROOT)
	mkdir -p -m 755 $(ROOT)/$(PKGROOT)/examples
	install -m 644 sge-namd*.sub $(ROOT)/$(PKGROOT)/examples/

clean::
	rm -rf $(SRC_DIRS) 
	rm -rf $(EXFILES)
	rm -rf $(VERSION.MK.INCLUDE)
