#!/bin/bash

# Check input arguments 
while [ "$1" != "" ]; do
    case $1 in
        -input)
             shift
             input=$1
             ;;
        -config)
             shift
             config=$1
             ;;
        -procs)
             shift
             procs=$1
             ;;
        *)   echo "Invalid argument in $@"
             exit 1
    esac
    shift
done

if test -z "$procs"; then
  echo "WARNING: Number of processors was not specified with the -procs option, defaults to 2"
  procs=2
fi

if test -z "$input"; then
  echo "ERROR: missing compressed input file"
  exit 1
fi

if test -z "$config"; then
  echo "ERROR: missing name of input configuration file"
  exit 1
fi

# Uncompress input file
ext=${input#*.}
inputdir=${input%%.*}

if test "$ext" = "zip"; then
  unzip $input
elif test "$ext" = "tar.gz"; then
  tar xzf $input
elif test "$ext" = "tgz"; then
  tar xzf $input
else 
  echo "Only .zip .tgz or tar.gz input files are supported"
  exit 1
fi

# get config file name with dir path
fname=`find . -name $config`
if test "$fname" = ""; then
  echo "ERROR: config file $config not found"
  exit 1
fi


# Create SGE submit file
SUB=namd.sub
touch $SUB
cat >> $SUB << EOF 
#$ -V
#$ -S /bin/bash
#$ -cwd
#$ -N NAMD
#$ -pe orte $procs
#$ -e $config.err
#$ -o $config.out

MPIHOME=/opt/openmpi/gnu/mx 
NAMDHOME=/share/apps/namd/2.9
export LD_LIBRARY_PATH=/lib64:/usr/lib64:\$MPIHOME/lib:\$NAMDHOME/lib:\$LD_LIBRARY_PATH

\$MPIHOME/bin/mpirun -np \$NSLOTS \$NAMDHOME/bin/namd2 $fname > $config-output

EOF

#export SGE_ROOT=/opt/gridengine
#export SGE_ARCH=lx26-amd64
#export SGE_CELL=default
#export SGE_EXECD_PORT=537
#export SGE_QMASTER_PORT=536

# Run job
qsub $SUB

