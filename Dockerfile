FROM ubuntu:18.04
MAINTAINER Eugenio Cividini <eugenio.cividini@mobygis.com>

ENV DEBIAN_FRONTEND noninteractive
RUN \
    apt-get update \
    && apt-get install -y software-properties-common \
    && add-apt-repository ppa:ubuntugis/ppa \
    && apt-get update \
    && apt-get install -y --allow-unauthenticated \
        gfortran \
        gfortran-5-multilib \
        csh \
        build-essential \
        libcloog-ppl1 \
        m4 \
        wget \
        ncl-ncarg \
        libgrib2c-dev \
        libjpeg-dev \
        libudunits2-dev \
        libsystemd-dev \
        curl \
        imagemagick \
        libjpeg-dev \
        libg2-dev \
        libg20 \
        libx11-6 \
        libxaw7 \
        libmagickwand-dev \
        git \
        autotools-dev \
        autoconf \
		libproj-dev \
        proj-bin \
        python-gdal \
        libgdal-dev \
        gdal-bin \
    && rm -rf /var/lib/apt/lists/*


ENV PREFIX /home/wrf
WORKDIR /home/wrf
ENV DEBIAN_FRONTEND noninteractive
ENV CC gcc
ENV CPP /lib/cpp -P
ENV CXX g++
ENV FC gfortran
ENV FCFLAGS -m64
ENV F77 gfortran
ENV FFLAGS -m64
ENV NETCDF $PREFIX
ENV NETCDFPATH $PREFIX
ENV WRF_CONFIGURE_OPTION 34
ENV WRF_EM_CORE 1
ENV WRF_NMM_CORE 0
ENV LD_LIBRARY_PATH_WRF $PREFIX/lib/
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH_WRF
ENV NCARG_ROOT=$PREFIX
ENV JASPERLIB=$PREFIX/lib
ENV JASPERINC=$PREFIX/include
ENV ARW_CONFIGURE_OPTION 3
ENV PATH $PATH:$PREFIX/bin:$NCARG_ROOT/bin:$PREFIX/WPS:$PREFIX/WRFV3/test/em_real:$PREFIX/WRFV3/main:$PREFIX/WRFV3/run:$PREFIX/WPS:$PREFIX
RUN mkdir -p /home/wrf && \
    useradd wrf -d /home/wrf && \
    chown -R wrf:wrf /home/wrf
RUN ulimit -s unlimited
USER wrf
COPY build_libraries.sh $PREFIX
RUN ./build_libraries.sh
COPY build_wrf.sh $PREFIX
RUN ./build_wrf.sh
COPY build_wps.sh $PREFIX
RUN ./build_wps.sh
COPY install_ncl.sh $PREFIX
RUN ./install_ncl.sh
ENV NCARG_ROOT=$PREFIX/ncl
COPY configuration_moby.sh $PREFIX
RUN ./configuration_moby.sh
COPY entrypoint.sh $PREFIX
ENTRYPOINT ["entrypoint.sh"]
CMD ["bash"]
VOLUME /home/wrf/data
VOLUME /home/wrf/work
USER root
RUN \apt-get -y autoremove --purge
