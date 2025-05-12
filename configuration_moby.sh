#!/bin/bash
#Eugenio Cividini

#Check the installation folders!
wpsG_folder=WPS/geogrid/src
wpsM_folder=WPS/metgrid/src
wpsU_folder=WPS/ungrib/src
wpsL_folder=WPS
wrf_folder=WRFV3/main

echo 'Final configuration routine - MobyGIS s.r.l'
echo '##################################'
echo 'The folder that will be searched are:'
echo $wpsG_folder
echo $wpsM_folder
echo $wpsU_folder
echo $wpsL_folder
echo $wrf_folder
echo '##################################'
echo 'Selecting the docker configuration'
echo '##################################'
echo 'Making the exec folder (geogrid.exe, link_grib.csh, ungrib.exe, metgrid.exe, real.exe, wrf.exe)'
mkdir -p $PREFIX/exec
if [ ! -d $PREFIX/$wpsG_folder ];then 
	echo "$PREFIX/$wpsG_folder doesn't exist, exiting"
	exit 1
fi
if [ ! -d $PREFIX/$wpsM_folder ];then 
	echo "$PREFIX/$wpsM_folder doesn't exist, exiting"
	exit 1
fi
if [ ! -d $PREFIX/$wpsU_folder ];then 
	echo "$PREFIX/$wpsU_folder doesn't exist, exiting"
	exit 1
fi
if [ ! -d $PREFIX/$wpsL_folder ];then 
	echo "$PREFIX/$wpsL_folder doesn't exist, exiting"
	exit 1
fi
if [ ! -d $PREFIX/$wrf_folder ];then 
	echo "$PREFIX/$wrf_folder doesn't exist, exiting"
	exit 1
fi
echo '##################################'
echo 'Searching WPS exec (geogrid.exe, link_grib.csh, ungrib.exe, metgrid.exe)'
if [ ! -x $PREFIX/$wpsG_folder/geogrid.exe ];then
	echo "Missing geogrid.exe executable, exiting"
	exit 1
fi
if [ ! -x $PREFIX/$wpsL_folder/link_grib.csh ];then
	echo "Missing link_grib.csh executable, exiting"
	exit 1
fi
if [ ! -x $PREFIX/$wpsU_folder/ungrib.exe ];then
	echo "Missing real.exe executable, exiting"
	exit 1
fi
if [ ! -x $PREFIX/$wpsM_folder/metgrid.exe ];then
	echo "Missing metgrid.exe executable, exiting"
	exit 1
fi
cp $PREFIX/$wpsG_folder/geogrid.exe $PREFIX/exec
cp $PREFIX/$wpsL_folder/link_grib.csh $PREFIX/exec
cp $PREFIX/$wpsU_folder/ungrib.exe $PREFIX/exec
cp $PREFIX/$wpsM_folder/metgrid.exe $PREFIX/exec
echo '##################################'
echo 'Searching WRF exec (real.exe, wrf.exe)'
if [ ! -x $PREFIX/$wrf_folder/real.exe ];then
	echo "Missing real.exe executable, exiting"
	exit 1
fi
if [ ! -x $PREFIX/$wrf_folder/wrf.exe ];then
	echo "Missing wrf.exe executable, exiting"
	exit 1
fi
cp $PREFIX/$wrf_folder/real.exe $PREFIX/exec
cp $PREFIX/$wrf_folder/wrf.exe $PREFIX/exec
#cp $PREFIX/$wrf_folder/ndown.exe $PREFIX/exec
#cp $PREFIX/$wrf_folder/tc.exe $PREFIX/exec
echo '##################################'
echo 'Listing the exec'
ls $PREFIX/exec
echo '##################################'
echo 'Removing all the useless data'
rm -r $PREFIX/WPS
rm -r $PREFIX/WRFV3
#rm -r $PREFIX/WPS40
echo '##################################'
echo "Now you can syncronize your local folders to $PREFIX/work for both WPS preprocessing and WRF model"
echo 'Goodbye!'


