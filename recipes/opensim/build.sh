#!/bin/bash

cd opensim-core-source
cd ..
mkdir build_dep
cd build_dep
cmake ../opensim-core-source/dependencies -LAH \
    -DCMAKE_OSX_SYSROOT=${CONDA_BUILD_SYSROOT} \
    -DCMAKE_OSX_DEPLOYMENT_TARGET=${MACOSX_DEPLOYMENT_TARGET} \
    -DCMAKE_BUILD_TYPE="Release" \
    -DSUPERBUILD_ezc3d=OFF \
    -DSUPERBUILD_simbody=OFF \
    -DCMAKE_INSTALL_PREFIX=../opensim_dependencies_install \
    -DCMAKE_INSTALL_LIBDIR="lib"
make --jobs ${CPU_COUNT}

cd ..
mkdir build
cd build
cmake ../opensim-core-source -LAH \
    -DCMAKE_OSX_SYSROOT=${CONDA_BUILD_SYSROOT} \
    -DCMAKE_OSX_DEPLOYMENT_TARGET=${MACOSX_DEPLOYMENT_TARGET} \
    -DCMAKE_BUILD_TYPE="Release" \
    -DOPENSIM_DEPENDENCIES_DIR=../opensim_dependencies_install \
    -DCMAKE_PREFIX_PATH="${PREFIX}" \
    -DSIMBODY_HOME="${PREFIX}" \
    -DBUILD_PYTHON_WRAPPING=ON \
    -DBUILD_TESTING=OFF \
    -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
    -DCMAKE_INSTALL_LIBDIR="lib" 
make --jobs ${CPU_COUNT}
make doxygen
make install