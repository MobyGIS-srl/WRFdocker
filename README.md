# ☁️ Dockerized WRF Weather Model 🌦️

Run the High-Resolution Weather Research and Forecasting (WRF) model and its related tools (WPS, NCL) within a Docker-based containerized environment.

[License](https://img.shields.io/github/license/your-github-user/your-repo.svg)](LICENSE) This project aims to provide a simple and reproducible way to run the WRF model without the need to manually install all dependencies on different operating systems.

## ✨ Features

* Pre-configured environment with WRF, WPS, and NCL.
* Isolates model and dependency installation.
* Ensures a consistent execution environment.
* Based on Ubuntu (see Dockerfile for specific version).


## 🚀 Prerequisites

To use this Docker image, you need to have Docker Engine installed on your system.


## 🏁 Getting Started

### Build

```bash
git clone [https://github.com/MobyGIS-srl/WRFdocker.git](https://github.com/MobyGIS-srl/WRFdocker.git)
cd WRFdocker
docker build -t wrf-docker:latest .
```

### Run
```bash
# Command run in the local WPS directory.
# Needs to map the local GEOG data directory to where WPS expects it inside the container.
docker run --rm \
           -v /local/path/to/current/wps/directory:/home/wrf/work \
           -v /local/path/to/geog/data:/home/wrf/WPS_GEOG \
           -u 1000:1000 \
           -w /home/wrf/work \
           wrf-docker:latest geogrid

# Command run in the local WPS directory.
# Needs to map the local directory containing grib files to the 'data' directory in the container.
docker run --rm \
           -v /local/path/to/current/wps/directory:/home/wrf/work \
           -v /local/path/to/input/grib/data:/home/wrf/data \
           -u 1000:1000 \
           -w /home/wrf/work \
           wrf-docker:latest ungrib

# Command run in the local WPS directory.
docker run --rm \
           -v /local/path/to/current/wps/directory:/home/wrf/work \
           -u 1000:1000 \
           -w /home/wrf/work \
           wrf-docker:latest metgrid

# Command run in the local WRF run directory.
# No symbolic links to metgrid or any other type: mv from WPS directory and cp from run directory.
docker run --rm \
           -v /local/path/to/current/wrf/directory:/home/wrf/work \
           -u 1000:1000 \
           -w /home/wrf/work \
           wrf-docker:latest real

# Command run in the local WRF run directory.
docker run --rm \
           -v /local/path/to/current/wrf/directory:/home/wrf/work \
           -u 1000:1000 \
           -w /home/wrf/work \
           wrf-docker:latest wrf

# Alternative run in the local WRF run directory, with symbolic link to metgrid output.
# This maps the local WPS output directory to a path expected by real inside the container.
docker run --rm \
           -v /local/path/to/current/wrf/directory:/home/wrf/work \
           -v /local/path/to/wps/output/directory:/home/wrf/WPS_Output \
           -u 1000:1000 \
           -w /home/wrf/work \
           wrf-docker:latest real

# Alternative run in the local WRF run directory, with symbolic link to metgrid output.
# This maps the local WPS output directory to a path expected by wrf inside the container.
docker run --rm \
           -v /local/path/to/current/wrf/directory:/home/wrf/work \
           -v /local/path/to/wps/output/directory:/home/wrf/WPS_Output \
           -u 1000:1000 \
           -w /home/wrf/work \
           wrf-docker:latest wrf

```