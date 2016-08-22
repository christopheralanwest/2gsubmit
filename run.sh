#!/bin/bash

# copy input files to batch directory
PWD=$LS_SUBCWD
RUNDIR=/pool/lsf/${USER}/${LSB_JOBID}
echo $PWD
cp -r $PWD $RUNDIR

# ensure that CMSSW is set up (to provide LHAPDF)
echo $SHELL
cd /afs/cern.ch/work/c/cawest/CMSSW_8_0_7_patch2/src
scramv1 runtime -csh
cd -

# run 2gNNLO
./2fot.exe
