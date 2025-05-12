#!/bin/bash

# set -euo pipefail
IFS=$'\n\t'

install_wrf() {
    wget http://www2.mmm.ucar.edu/wrf/src/WRFV3.9.1.1.TAR.gz -P $PREFIX
    tar -zxvf $PREFIX/WRFV3.9.1.1.TAR.gz -C $PREFIX
    rm -f $PREFIX/WRFV3.9.1.1.TAR.gz
    cd $PREFIX/WRFV3
	sed -i 's/I_really_want_to_output_grib2_from_WRF = "FALSE" ;/I_really_want_to_output_grib2_from_WRF = "TRUE" ;/g' arch/Config_new.pl #Grib2 output
    echo $WRF_CONFIGURE_OPTION | ./configure
    ./compile em_real
}


install_all() {
    install_wrf
}

install_all


