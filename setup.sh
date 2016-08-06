#!/bin/bash

# set up CMSSW environment to get LHAPDF
eval `scramv1 runtime -sh`

# specify LHAPDF location
LHAPDF=`scram tool info lhapdf | grep LIBDIR | cut -d '=' -f 2`
DIRNAME=2gNNLO_2.1

echo "Using LHAPDF from location " ${LHAPDF}

# get 2gNNLO v2.1
if [ !  -e  ${DIRNAME}  ]
then
    wget http://www.physik.uzh.ch/~lcieri/2gNNLO_2.1.tar.gz
    tar xvf 2gNNLO_2.1.tar.gz
fi

# patch 2gNNLO to produce distributions of interest
for i in `ls patches`
do 
    echo "patching "${i}
    patch ${DIRNAME}"/src/"${i} "patches/"${i} 
done

# replace LHAPDF with custom version
sed -i 's|/usr/local/share/lhapdf/PDFsets/lib|'"$LHAPDF"'|g' ${DIRNAME}/src/Makefile

# make 2gNNLO
cd ${DIRNAME}
make
