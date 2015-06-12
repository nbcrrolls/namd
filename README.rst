.. hightlight:: rst

NAMD Roll
================
NAMD - Scalable Molecular Dynamics 
This roll is based on triton's chemistry roll with modifications
to enable cuda.

.. contents::

Introduction
--------------
This roll installs NAMD tools. 
There are 2 flavors compiled for each compiler (gnu, intel): ::

    cuda mpi
    non-cuda mpi

Downloads
-----------
NAMD is a licensed software.  Follow a download link info: ::

    NAMD - http://www.ks.uiuc.edu/Development/Download/download.cgi?UserID=&AccessCode=&ArchiveID=1257
    fftw - http://www.fftw.org/download.html
    tcl  - http://sourceforge.net/projects/tcl/files/Tcl/8.6.3/tcl8.6.3-src.tar.gz

Building the roll
------------------
**Dependencies**

- The ``mpi`` roll must be installed on the build/install host. 
  depends on mpi libraries. 
- The ``intel`` roll must be installed on the build/install host. In the absence of intel compiler
  the roll should be buld with ``ROLLCOMPILER='gnu'``. 
- The ``cuda`` roll must be installed on build/install host . In the absence of cuda, the roll should
  be build with ROLLCUDA="nocuda"
- The roll sources assumes that modulefiles provided by ``intel``, ``cuda`` and ``mpi``
  rolls are available.

The roll uses ``openmpi`` compiled with intel and gnu compilers for ``eth`` fabric. 
ROLLCOMPILER, ROLLNETWORK and ROLLMPI variables are set in Makefile.
The build process currently supports one or more of the values for the variables: ::

    ROLLCOMPILER: gnu, intel (default gnu)
    ROLLMPI     : openmpi (default openmpi)  
    ROLLNETWORK : eth (default)
    ROLLCUDA    : nocuda (default)

To make a roll and create executable for cuda/non-cuda for intel and gnu compielrs run: ::

    # make ROLLCOMPILER="gnu intel" ROLLMPI=openmpi ROLLNETWORK=eth ROLLCUDA="cuda nocuda" 2>&1 | tee build.log

A successful build will create the file ``namd-*.disk1.iso``.  

Installing
-------------

To install, execute these instructions on a Rocks frontend: ::

    # rocks add roll *.iso
    # rocks enable roll namd
    # (cd /export/rocks/install; rocks create distro)
    # rocks run roll namd | bash
    
The installation of cuda-enabled RPMS will be done only on the nodes that have cuda installed 
and the node attribute cuda is set. The attribute is set during installtion of cuda roll with: ::

    # rocks set host attr compute-X-Y cuda true

What is installed
-------------------

The roll installs namd and environment module files in: ::

    /opt/namd<VERSION>/gnu - compiled with GNU
    /opt/namd<VERSION>/intel - compiled with Intel compilers
    /opt/namd2.10/examples - example SGE submit scripts
    /opt/namd2.10/tiny - example input for NAMD run
    /opt/modulefiles/applications/namd<VERSION> - environment modules
    /root/rolltests/namd.t  - roll installation test

**Testing**

A test script ``namd.t`` can be run to verify proper
installation of the roll binaries and module files. To
run the test scripts execute the following command(s): ::

    # /root/rolltests/amber.t 

