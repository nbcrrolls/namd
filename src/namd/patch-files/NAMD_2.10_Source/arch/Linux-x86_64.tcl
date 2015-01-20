
TCLDIR=/opt/namd2.10/gnu
TCLINCL=-I$(TCLDIR)/include

TCLLIB=-L$(TCLDIR)/lib -ltcl8.6 -ldl -lpthread
TCLFLAGS=-DNAMD_TCL
TCL=$(TCLINCL) $(TCLFLAGS)



