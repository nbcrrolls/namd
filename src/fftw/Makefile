#
# $Id: Makefile,v 1.1 2012/07/12 00:14:09 nadya Exp $
#
# @Copyright@
# @Copyright@

PKGROOT = /share/apps/namd/$(VERSION)

REDHAT.ROOT = $(PWD)/../../

-include $(ROCKSROOT)/etc/Rules.mk
include Rules.mk

OPTS = --enable-float
SOURCE = $(FFTW)-$(FFTWVER)

version.mk:
	cat ../version.mk version.mk.in > version.mk

build:
	tar zxf $(SOURCE).$(EXT)
	(                                                 \
		cd $(SOURCE);                    \
		./configure --prefix=$(PKGROOT) $(OPTS) ; \
	)
	
install::
	mkdir -p  $(ROOT)/$(PKGROOT)
	(                                                 \
		cd $(SOURCE);                    \
		make -j8 ;                                \
		make DESTDIR=$(ROOT) install ;            \
	)

clean::
	rm -rf $(SOURCE)
	rm -rf version.mk
