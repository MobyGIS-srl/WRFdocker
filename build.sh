#!/bin/bash

# set -euo pipefail
IFS=$'\n\t'

install_zlib() {
    git clone https://github.com/madler/zlib $PREFIX/zlib
    cd $PREFIX/zlib
    ./configure --prefix=$PREFIX
    make
    make install
}


install_netcdf_c() {
    curl -L -S https://github.com/Unidata/netcdf-c/archive/v4.5.tar.gz -o $PREFIX/netcdf-4.5.tar.gz
    tar zxvf $PREFIX/netcdf-4.5.tar.gz -C $PREFIX
    rm $PREFIX/netcdf-4.5.tar.gz
    mv $PREFIX/netcdf-c-4.5 $PREFIX/netcdf-c
    cd $PREFIX/netcdf-c
    LD_LIBRARY_PATH=$PREFIX/lib CPPFLAGS=-I$PREFIX/include LDFLAGS=-L$PREFIX/lib ./configure --prefix=$PREFIX --disable-dap --disable-netcdf-4 --disable-shared
    make
    make install
}

install_netcdf_fortran() {
    curl -L -S https://github.com/Unidata/netcdf-fortran/archive/v4.4.4.tar.gz -o $PREFIX/netcdf-fortran-4.4.4.tar.gz
    tar zxvf $PREFIX/netcdf-fortran-4.4.4.tar.gz -C $PREFIX
    rm $PREFIX/netcdf-fortran-4.4.4.tar.gz
    mv $PREFIX/netcdf-fortran-4.4.4 $PREFIX/netcdf-fortran
    cd $PREFIX/netcdf-fortran
    ./configure --prefix=$PREFIX
    make
    make install
}

install_mpich() {
    curl --max-time 900 -L -S http://www.mpich.org/static/downloads/3.2/mpich-3.2.tar.gz -o $PREFIX/mpich-3.2.tar.gz
    tar zxvf $PREFIX/mpich-3.2.tar.gz -C $PREFIX
    rm $PREFIX/mpich-3.2.tar.gz
    mv $PREFIX/mpich-3.2 $PREFIX/mpich
    cd $PREFIX/mpich
    ./configure --prefix=$PREFIX
    make
    make install
}

install_wrf() {
    wget http://www2.mmm.ucar.edu/wrf/src/WRFV3.9.1.1.TAR.gz -P $PREFIX
    tar -zxvf $PREFIX/WRFV3.9.1.1.TAR.gz -C $PREFIX
    rm -f $PREFIX/WRFV3.9.1.1.TAR.gz
    cd $PREFIX/WRFV3
    echo $WRF_CONFIGURE_OPTION | ./configure
    ./compile em_real
}

install_libpng() {
    curl --max-time 900 -L -S http://www2.mmm.ucar.edu/wrf/OnLineTutorial/compile_tutorial/tar_files/libpng-1.2.50.tar.gz -o $PREFIX/libpng-1.2.50.tar.gz
    tar -zxvf $PREFIX/libpng-1.2.50.tar.gz -C $PREFIX
    rm $PREFIX/libpng-1.2.50.tar.gz
    cd $PREFIX/libpng-1.2.50
    CPPFLAGS=-I$PREFIX/include LDFLAGS=-L$PREFIX/lib ./configure --prefix=$PREFIX
    make
    make install
}

install_jasper() {
    curl --max-time 900 -L -S http://www2.mmm.ucar.edu/wrf/OnLineTutorial/compile_tutorial/tar_files/jasper-1.900.1.tar.gz -o $PREFIX/jasper-1.900.1.tar.gz
    tar -zxvf $PREFIX/jasper-1.900.1.tar.gz -C $PREFIX
    rm $PREFIX/jasper-1.900.1.tar.gz
    cd $PREFIX/jasper-1.900.1
    ./configure --prefix=$PREFIX
    make
    make install
}

install_wps() {
	wget http://www2.mmm.ucar.edu/wrf/src/WPSV3.9.1.TAR.gz -P $PREFIX
	tar zxvf $PREFIX/WPSV3.9.1.TAR.gz -C $PREFIX
	rm $PREFIX/WPSV3.9.1.TAR.gz
    cd $PREFIX/WPS
    echo 1 | NCARG_ROOT=$PREFIX PATH=$NCARG_ROOT/bin:$PATH NETCDF=$PREFIX JASPERLIB=$PREFIX/lib JASPERINC=$PREFIX/include ./configure #Option 1 (echo 1) configuration (serial)!!!, Ok grib2; Option 3 (echo 3) for dmpar with grib2 support
    ./compile
}

install_wps40() {
	wget http://www2.mmm.ucar.edu/wrf/src/WPSV4.0.TAR.gz -P $PREFIX
	tar zxvf $PREFIX/WPSV4.0.TAR.gz -C $PREFIX
	rm $PREFIX/WPSV4.0.TAR.gz
    cd $PREFIX/WPS
    echo 1 | NCARG_ROOT=$PREFIX PATH=$NCARG_ROOT/bin:$PATH NETCDF=$PREFIX JASPERLIB=$PREFIX/lib JASPERINC=$PREFIX/include ./configure #Option 1 configuration!!!, Ok grib2
    ./compile
}

install_all() {
    install_netcdf_c
    install_netcdf_fortran
    install_mpich
    install_zlib
    install_libpng
    install_jasper
    install_wrf
    #install_wps
	install_wps40
}

if [ ! -d /home/wrf/data ]; then
    mkdir /home/wrf/data
fi

install_all


