#!/bin/bash

# set -euo pipefail
IFS=$'\n\t'

install_wps() {
	wget http://www2.mmm.ucar.edu/wrf/src/WPSV3.9.1.TAR.gz -P $PREFIX
	tar zxvf $PREFIX/WPSV3.9.1.TAR.gz -C $PREFIX
	rm $PREFIX/WPSV3.9.1.TAR.gz
    cd $PREFIX/WPS
    echo 1 | NCARG_ROOT=$PREFIX PATH=$NCARG_ROOT/bin:$PATH NETCDF=$PREFIX JASPERLIB=$PREFIX/lib JASPERINC=$PREFIX/include ./configure #Option 1 configuration!!!, Ok grib2
    ./compile
}

install_wps40() {
	wget http://www2.mmm.ucar.edu/wrf/src/WPSV4.0.TAR.gz -P $PREFIX
	tar zxvf $PREFIX/WPSV4.0.TAR.gz -C $PREFIX
	rm $PREFIX/WPSV4.0.TAR.gz
    cd $PREFIX/WPS
    echo 1 | NCARG_ROOT=$PREFIX PATH=$NCARG_ROOT/bin:$PATH NETCDF=$PREFIX JASPERLIB=$PREFIX/lib JASPERINC=$PREFIX/include ./configure #Option 1 (echo 1) configuration (serial)!!!, Ok grib2; Option 3 (echo 3) for dmpar with grib2 support
    ./compile
}

install_all() {
    #install_wps
	install_wps40
}

if [ ! -d /home/wrf/data ]; then
    mkdir /home/wrf/data
fi

install_all


