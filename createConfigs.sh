#!/bin/bash

#My inputs
# 1.input file input.txt
# 2.center of mass energy
# 3-4.ptmin1,2
# 5.etamax
# 6-7.crack eta
# 8-9.mass range
# 10-11: gen isolation: cone and cut value
# 12-14: output format: root histos, root ntuples, topdrawer histos
# 15-17: contributions to switch on: born, nlo, nnlo
# 18-20: run options: born, nlo, nnlo (1,2,3)

sourcefile=$1;
category=$2;
option=$3;

if [ -z "$sourcefile" ]; then
    echo "ERROR: You need to provide at least an input file"
    exit
fi

if [ -z "$category" ]; then
    echo "ERROR: You need to provide at least a configuration name."
    exit
fi

if [ -z "$option" ]; then
    echo "ERROR: You need to provide at least an option (START, CONTINUE, RESTART)"
    exit
fi


cme=13000.0
ptmin1=75.0
ptmin2=75.0
etamax=2.5
eta1max=2.5
eta2max=2.5
eta1min=0.
eta2min=0.
cracketamin=1.4442
cracketamax=1.560
massmin=300.0
massmax=2000.0
isolcone=0.4
isolvalue=5.0
saveroothistos=1
saverootntuples=0
savetopdhistos=1
renscalefactor=1.0
facscalefactor=1.0
pdfname="MSTW2008nnlo68cl.LHgrid"

if [[ "$category" == *"BB"* ]]; then
    eta1max=1.5
    eta2max=1.5
    eta1min=0.
    eta2min=0.
fi

if [[ "$category" == *"BE"* ]]; then
    eta1max=1.5
    eta2max=2.5
    eta1min=0.
    eta2min=1.5
fi

if [[ "$category" == *"EB"* ]]; then
    eta1max=2.5
    eta2max=1.5
    eta1min=1.5
    eta2min=0.
fi

if [[ "$category" == *"EE"* ]]; then
    eta1max=2.5
    eta2max=2.5
    eta1min=1.5
    eta2min=1.5
fi

if [[ "$category" == *"BORN"* ]]; then
    bornon=1
    nloon=0
    nnloon=0
fi

if [[ "$category" == *"_NLO"* ]]; then
# born contribution needs to be recalculated 
# with NLO PDF
    #bornon=0
    bornon=1
    nloon=1
    nnloon=0
fi

if [[ "$category" == *"_NNLO"* ]]; then
# born+NLO contribution needs to be recalculated
# with NNLO PDF 
    #bornon=0
    #nloon=0
    bornon=1
    nloon=1
    nnloon=1
fi

if [[ "$category" == *"_DEFAULT"* ]]; then
    cme=14000.0
fi

if [ "$option" == "START" ]; then
    optionbornon=1
    optionnloon=1
    optionnnloon=1
fi

if [ "$option" == "CONTINUE" ]; then
    optionbornon=2
    optionnloon=2
    optionnnloon=2
fi

if [ "$option" == "RESTART" ]; then
    optionbornon=3
    optionnloon=3
    optionnnloon=3
fi

if [[ "$category" == *"R2F2"* ]]; then
    renscalefactor=2.0
    facscalefactor=2.0
fi

if [[ "$category" == *"R0p5F0p5"* ]]; then
    renscalefactor=0.5
    facscalefactor=0.5
fi

if [[ "$category" == *"R1F1"* ]]; then
    renscalefactor=1.
    facscalefactor=1.
fi

if [[ "$category" == *"8TeV"* ]]; then
    cme=8000.0
    ptmin1=80.0
    ptmin2=80.0
    massmin=200.0
fi

# for 2015/2016 data
if [[ "$category" == *"Mass0p23To2TeV"* ]]; then
    massmin=230.0
    massmax=2000.0
    isolcone=0.3
    if [[ "$category" == *"BE"* ]]; then
	massmin=320.0
    fi
    # use same PDF that is used in the Sherpa sample
    if [[ "$category" == *"BORN"* ]]; then
	pdfname="CT10.LHgrid"
    elif [[ "$category" == *"_NLO"* ]]; then
	pdfname="CT10nlo.LHgrid"
    elif  [[ "$category" == *"_NNLO"* ]]; then
	pdfname="CT10nnlo.LHgrid"
    fi
fi


if [[ "$category" == *"Mass0p02To0p2TeV"* ]]; then
    massmin=20.0
    massmax=200.0
fi

if [[ "$category" == *"Mass0p15To1TeV"* ]]; then
    massmin=150.0
    massmax=1000.0
fi

if [[ "$category" == *"Mass0p2To2TeV"* ]]; then
    massmin=200.0
    massmax=2000.0
fi

if [[ "$category" == *"Mass0p3To1TeV"* ]]; then
    massmin=300.0
    massmax=1000.0
fi

if [[ "$category" == *"Mass1To2TeV"* ]]; then
    massmin=1000.0
    massmax=2000.0
fi

if [[ "$category" == *"Mass2To3TeV"* ]]; then
    massmin=2000.0
    massmax=3000.0
fi

if [[ "$category" == *"Mass3To4TeV"* ]]; then
    massmin=3000.0
    massmax=4000.0
fi

# selections to reproduce PRL 108, 072001 (2012)
if [[ "$category" == *"PRL"* ]]; then
    cme=14000.0
    ptmin1=40.0
    ptmin2=25.0
# negative signs are used to disable a cut
#    cracketamin=-1.44
#    cracketamax=-1.57
    cracketamin=1.44
    cracketamax=1.57
    massmin=20.0
    massmax=250.0
fi


if [ -f input.txt ]; then
    rm input.txt
fi
cp $sourcefile input.txt


sed -i s/TEMPLATECME/$cme/g input.txt
sed -i s/TEMPLATEPTMIN1/$ptmin1/g input.txt
sed -i s/TEMPLATEPTMIN2/$ptmin2/g input.txt
sed -i s/TEMPLATEETAMAX/$etamax/g input.txt
sed -i s/TEMPLATEETA1MAX/$eta1max/g input.txt
sed -i s/TEMPLATEETA2MAX/$eta2max/g input.txt
sed -i s/TEMPLATEETA1MIN/$eta1min/g input.txt
sed -i s/TEMPLATEETA2MIN/$eta2min/g input.txt
sed -i s/TEMPLATECRACKETAMIN/$cracketamin/g input.txt
sed -i s/TEMPLATECRACKETAMAX/$cracketamax/g input.txt
sed -i s/TEMPLATEMASSMIN/$massmin/g input.txt
sed -i s/TEMPLATEMASSMAX/$massmax/g input.txt
sed -i s/TEMPLATEISOLCONE/$isolcone/g input.txt
sed -i s/TEMPLATEISOLVALUE/$isolvalue/g input.txt
sed -i s/TEMPLATESAVEROOTHISTOS/$saveroothistos/g input.txt
sed -i s/TEMPLATESAVEROOTNTUPLES/$saverootntuples/g input.txt
sed -i s/TEMPLATESAVETOPHISTOS/$savetopdhistos/g input.txt
sed -i s/TEMPLATEBORNON/$bornon/g input.txt
sed -i s/TEMPLATENLOON/$nloon/g input.txt
sed -i s/TEMPLATENNLOON/$nnloon/g input.txt
sed -i s/TEMPLATERUNOPTIONBORN/$optionbornon/g input.txt
sed -i s/TEMPLATERUNOPTIONNLO/$optionnloon/g input.txt
sed -i s/TEMPLATERUNOPTIONNNLO/$optionnnloon/g input.txt
sed -i s/TEMPLATERENSCALEFACTOR/$renscalefactor/g input.txt
sed -i s/TEMPLATEFACSCALEFACTOR/$facscalefactor/g input.txt
sed -i s/TEMPLATEPDFNAME/$pdfname/g input.txt
