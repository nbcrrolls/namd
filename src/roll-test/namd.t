#!/usr/bin/perl -w
# namd roll installation test.  Usage:
# namd.t [nodetype]
#   where nodetype is one of "Compute", "Dbnode", "Frontend" or "Login"
#   if not specified, the test assumes either Compute or Frontend

use Test::More qw(no_plan);

my $appliance = $#ARGV >= 0 ? $ARGV[0] : -d '/export/rocks/install' ? 'Frontend' : 'Compute';
my $installedOnAppliancesPattern = '.';
my $isInstalled;
my $output;

my $TESTFILE = 'tmpnamd';

my @COMPILERS = split(/\s+/, 'ROLLCOMPILER');
my @NETWORKS = split(/\s+/, 'ROLLNETWORK');
my @MPIS = split(/\s+/, 'ROLLMPI');
my @OPTCUDA = split(/\s+/, 'ROLLCUDA');

my $NVER = VERSION;

$packageHome = "/opt/namd$NVER";
$testDir = "$packageHome/tiny";
SKIP: {
  skip 'namd test not installed', 1 if ! -d $testDir;
}

foreach my $mpi (@MPIS) {
  foreach my $compiler (@COMPILERS) {
    my $compilername = (split('/', $compiler))[0];
    SKIP: {
      $isInstalled = -d "/opt/namd$NVER/$compilername";
      if($appliance =~ /$installedOnAppliancesPattern/) {
        ok($isInstalled, "$compilername-compiled namd installed");
      } else {
        ok(! $isInstalled, "$compilername-compiled namd not installed");
      }

      foreach my $optcuda (@OPTCUDA) {
        my $mycuda = "";
        if($optcuda eq "cuda") {
          $mycuda="-cuda"
        }
        SKIP: {
          my $dir = "/opt/modulefiles/applications/namd$NVER";
          `/bin/ls $dir/$compilername$mycuda 2>&1`;
          ok($? == 0, "namd$NVER/$compilername$mycuda module installed");
          `/bin/ls $dir/.version.$compilername$mycuda 2>&1`;
          ok($? == 0, "namd$NVER/$compilername$mycuda version module installed");

          open(OUT, ">$TESTFILE.sh");
          print OUT <<END;
module load namd$NVER/$compiler$mycuda
cd $testDir
$packageHome/$compilername$mycuda/bin/namd2 tiny.namd
END
          close(OUT);
          $output = `/bin/bash $TESTFILE.sh`;
          ok($output =~ /WRITING VELOCITIES/, "namd$NVER/$compilername$mycuda sample run");
          `/bin/rm $testDir/FFTW*`;
        }
      }
    }
  }
}

`rm -fr $TESTFILE*`;

