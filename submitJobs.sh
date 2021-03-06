#!/bin/bash

basedir=`pwd`
location='CERN'
#regionsArray='PRL'
#regionsArray='BB'
regionsArray='BB BE'
contribsArray='BORN NLO NNLO'
renfacscalesArray='R1F1 R2F2 R0p5F0p5'
#renfacscalesArray='R2F2 R0p5F0p5'
#renfacscalesArray='R1F1'
massbinsArray='Mass0p23To2TeV'
#massbinsArray='Mass0p02To0p2TeV'
#massbinsArray='Mass0p2To2TeV'
#massbinsArray='Mass0p3To1TeV Mass1To2TeV'
#massbinsArray='Mass0p15To1TeV Mass1To2TeV Mass2To3TeV Mass3To4TeV'
##massbinsArray='Mass0p3To1TeV'
# name of 2gNNLO directory
DIRNAME="2gNNLO_2.1"

./setup.sh

# default queue names 
mainQueue='main'
longQueue='long'

if [[ "$location" == "CERN" ]]; then
    mainQueue='1nw'
    longQueue='2nw'
fi

mkdir -p $basedir/JOBSUBMISSION
DIRDATE=$(date +%F-%T | sed 's/:/-/g')
mkdir -p $basedir/JOBSUBMISSION/$DIRDATE

numjobs=10

for k in $renfacscalesArray
do
    for i in $regionsArray
    do
	for m in $massbinsArray
	do
	    for j in $contribsArray
	    do
		cd $basedir
		mkdir -p SUBMITDIR
		rm -rf SUBMITDIR/*
		cd SUBMITDIR
		cp -r $basedir/$DIRNAME .
		cd $DIRNAME
		echo $i"_"$j"_"$k"_"$m
		echo category $i"_"$j"_"$k"_"$m"_13TeV"
		$basedir/createConfigs.sh $basedir/input.txt.TEMPLATE $i"_"$j"_"$k"_"$m"_13TeV" START
		cp $basedir/SUBMITDIR/$DIRNAME/input.txt bin
		echo "Current directory: "`pwd`
		make clean
		make install
		if [[ "$j" == *"NNLO"* ]]; then
		    numjobs=50
		else
		    numjobs=10
		fi
		echo $numjobs "jobs to be submitted for this task"
		mkdir -p $basedir/JOBSUBMISSION/$DIRDATE/$i"_"$j"_"$k"_"$m"_13TeV"
		for (( l=1; l<=$numjobs; l++ ))
		do
		    # create job directory and copy files into it
		    mkdir -p $basedir/JOBSUBMISSION/$DIRDATE/$i"_"$j"_"$k"_"$m"_13TeV"/"Job"$l
		    cp -r * $basedir/JOBSUBMISSION/$DIRDATE/$i"_"$j"_"$k"_"$m"_13TeV"/"Job"$l
		    cp -r $basedir/$DIRNAME $basedir/JOBSUBMISSION/$DIRDATE/$i"_"$j"_"$k"_"$m"_13TeV"/"Job"$l/bin
		    cp $basedir/run.sh $basedir/JOBSUBMISSION/$DIRDATE/$i"_"$j"_"$k"_"$m"_13TeV"/"Job"$l/bin
		    cd $basedir/JOBSUBMISSION/$DIRDATE/$i"_"$j"_"$k"_"$m"_13TeV"/"Job"$l/bin
		    if [[ "$j" == *"NNLO"* ]]; then
			echo "Submitting to queue "$longQueue
			if [[ "$k" == "R1F1" ]]; then
			## require a cpuf>4 to avoid getting stuck on a crummy host
			    bsub -q $longQueue -R "cpuf>4" -J "job"$l"_"$i"_"$j"_"$k"_13TeV" -o output.txt `pwd`/run.sh
			else
			    bsub -q $longQueue -J "job"$l"_"$i"_"$j"_"$k"_13TeV" -o output.txt `pwd`/run.sh
			fi
		    else
			echo "Submitting to queue "$mainQueue
			bsub -q $mainQueue -J "job"$l"_"$i"_"$j"_"$k"_13TeV" -o output.txt `pwd`/run.sh
		    fi
		    cd -
		done ##end of loop over number of jobs
	    done ##end of loop over contributions (BORN, NLO, NNLO)
	done ## end of loop over mass bins (0.3-1, 1-2, 2-3, 3-4 TeV)
    done ##end of loop over regions (BB,EB,BE,EE,ALL)
done ##end of loop over ren and fac scales

