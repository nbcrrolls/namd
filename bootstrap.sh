#!/bin/bash

# Compile and install NAMD prerequisites

if [ $# -ne 1 ]; then
    echo "Usage: $0 compiler"
    echo "    compiler can be gnu, intel or pgi (pgi is not tested for NBCR)"
    exit 0
fi 

# build and install fftw 
(cd src/fftw; make ROLLCOMPILER=$1 rpm; make clean)
rpm -i RPMS/x86_64/namd-fftw-$1*.rpm

# build and install tcl 
(cd src/tcl; make ROLLCOMPILER=$1 rpm; make clean)
rpm -i RPMS/x86_64/namd-tcl-$1*.rpm