#!/bin/bash

#################################
# Entry point script
#################################

set -e

re='^[0-9]+$'
if [ -z "$2" ];then
	np=1
elif ! [[ $2 =~ $re ]];then
	echo "The number of processors must be an integer!"
	exit 1
else
	np=$2
fi

echo "Number of processors (real and wrf): $np"

if [ "$1" = 'geogrid' ]; then
     cd $PREFIX/work
     $PREFIX/exec/./geogrid.exe
     cd /home
elif [ "$1" = 'ungrib' ]; then
     cd $PREFIX/work
     #ln -s -f ungrib/Variable_Tables/* Vtable #Remember to link/have a Vtable in the syncronized folder
     $PREFIX/exec/./link_grib.csh $PREFIX/data/*
     $PREFIX/exec/./ungrib.exe
     cd /home
elif [ "$1" = 'metgrid' ]; then
     cd $PREFIX/work
     $PREFIX/exec/./metgrid.exe
     cd /home
elif [ "$1" = 'real' ]; then
     cd $PREFIX/work
     #ln -s -f $PREFIX/WPS/met_em.d* #Remember to link/have the file met_em in the syncronized folder
     mpirun -np $np $PREFIX/exec/./real.exe
     cd /home
elif [ "$1" = 'wrf' ]; then
     cd $PREFIX/work
     mpirun -np $np $PREFIX/exec/./wrf.exe
     cd /home
elif [ "$1" = 'ncl' ]; then
     cd $PREFIX/work
     echo $NCARG_ROOT
     /$PREFIX/ncl/bin/ncl $3
     cd /home
else
    echo "Wrong argument! Use: geogrid, ungrib, metgrid, real, wrf, ncl."
	echo "You can also select the number of processors (real and wrf) as second argument."
fi


