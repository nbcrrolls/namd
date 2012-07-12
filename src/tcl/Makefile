#
# $Id: Makefile,v 1.1 2012/07/12 00:14:13 nadya Exp $
#
# @Copyright@
# @Copyright@

PKGROOT = /share/apps/namd/$(VERSION)

REDHAT.ROOT = $(PWD)/../../

-include $(ROCKSROOT)/etc/Rules.mk
include Rules.mk

OPTS = 
SOURCE = $(TCL)$(TCLVER)

version.mk:
	cat ../version.mk version.mk.in > version.mk

build:
	tar zxf $(SOURCE)-src.$(EXT)
	(                                                 \
		cd $(SOURCE)/unix;                    \
		./configure --prefix=$(PKGROOT) $(OPTS) ; \
	)
	
install::
	mkdir -p  $(ROOT)/$(PKGROOT)
	(                                                 \
		cd $(SOURCE)/unix;                    \
		make -j8 ;                                \
		make DESTDIR=$(ROOT) install ;            \
	)

clean::
	rm -rf $(SOURCE)
	rm -rf version.mk
