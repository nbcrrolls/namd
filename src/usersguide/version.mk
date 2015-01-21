
VERSION.MK.MASTER = version.mk
VERSION.MK.MASTER.DIR = ..
VERSION.MK.INCLUDE = namd.version.mk
include $(VERSION.MK.INCLUDE)

ROLL			= namd
NAME    		= roll-$(ROLL)-usersguide

SUMMARY_COMPATIBLE	= $(VERSION)
SUMMARY_MAINTAINER	= Rocks Group
SUMMARY_ARCHITECTURE	= x86_64

ROLL_REQUIRES		= base kernel os mpi
ROLL_CONFLICTS		= 

PKGROOT         = /var/www/html/roll-documentation/namd/$(VERSION)

