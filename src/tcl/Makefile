#
# $Id: Makefile,v 1.1 2012/07/12 00:14:13 nadya Exp $
#
# @Copyright@
# @Copyright@

REDHAT.ROOT = $(PWD)/../../

-include $(ROCKSROOT)/etc/Rules.mk
include Rules.mk
include $(NBCRDEVEL)/NBCR.mk

OPTS = 

pretar:: $(VERSION.MK.INCLUDE)

info:
	echo $(PKGROOT)

$(VERSION.MK.INCLUDE): 
	if [ -f $(VERSION.MK.MASTER.DIR)/$(VERSION.MK.MASTER) ]; then \
	    /bin/cp $(VERSION.MK.MASTER.DIR)/$(VERSION.MK.MASTER) $@; \
	fi


build: $(SRC_DIRS)
	(                                                 \
		cd $(SOURCE_DIR)/unix;                    \
		./configure --prefix=$(PKGROOT) $(OPTS) ; \
	)
	
install::
	mkdir -p  $(ROOT)/$(PKGROOT)
	(                                                 \
		cd $(SOURCE_DIR)/unix;                    \
		make -j8 ;                                \
		make DESTDIR=$(ROOT) install ;            \
	)

clean::
	rm -rf $(SOURCE_DIR)
	rm -rf $(VERSION.MK.INCLUDE)
