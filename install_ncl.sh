#!/bin/bash

# set -euo pipefail
IFS=$'\n\t'

install_ncl() {
	wget 'https://www.earthsystemgrid.org/dataset/ncl.662.dap/file/ncl_ncarg-6.6.2-Debian9.8_64bit_gnu630.tar.gz'
	mkdir -p $PREFIX/ncl
	tar zxvf $PREFIX/ncl_ncarg-6.6.2-Debian9.8_64bit_gnu630.tar.gz -C $PREFIX/ncl
}


install_all() {
	install_ncl
}


install_all


