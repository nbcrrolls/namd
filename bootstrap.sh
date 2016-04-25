#!/bin/bash

# Compile and install NAMD prerequisites
# NAMD distro NAMD_2.10_Source.tar.gz is available on google drive on nbcr.ucsd@gmail.com 
# or from nbcrrolls/source private repo


if [ $# -ne 1 ]; then
    echo "Usage: $0 compiler"
    echo "    compiler can be gnu, intel or pgi (pgi is not tested for NBCR)"
    exit 0
fi 

if [ ! -d $NBCRDEVEL ]; then
    echo "Need to install roll 'nbcr' first"
    exit 1
fi

# set google url for dowloading sources
. $NBCRDEVEL/bootstrap-values.sh

# download sources
. $ROLLSROOT/etc/bootstrap-functions.sh
echo ""
echo "WARNING: before making a roll download NAMD source from nbcr.ucsd@gmail.com goodledrive in privaterools/"
echo ""


exit

# build and install fftw 
(cd src/fftw; make ROLLCOMPILER=$1 rpm; make ROLLCOMPILER=$1 clean)
rpm -i RPMS/x86_64/namd-fftw-$1*.rpm

# build and install tcl 
(cd src/tcl; make ROLLCOMPILER=$1 rpm; make ROLLCOMPILER=$1 clean)
rpm -i RPMS/x86_64/namd-tcl-$1*.rpm
