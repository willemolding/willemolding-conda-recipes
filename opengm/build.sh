export DYLIB="so"


##
## START THE BUILD
##
mkdir build
cd build

CXXFLAGS="${CXXFLAGS} -I${PREFIX}/include"
LDFLAGS="${LDFLAGS} -Wl,-rpath,${PREFIX}/lib -L${PREFIX}/lib"

## first run cmake for the external libs
cmake .. \
        -DCMAKE_C_COMPILER=${PREFIX}/bin/gcc \
        -DCMAKE_CXX_COMPILER=${PREFIX}/bin/g++ \
        -DCMAKE_OSX_DEPLOYMENT_TARGET=10.7\
        -DCMAKE_INSTALL_PREFIX=${PREFIX} \
        -DCMAKE_PREFIX_PATH=${PREFIX} \
        -DCMAKE_SHARED_LINKER_FLAGS="${LDFLAGS}" \
        -DCMAKE_EXE_LINKER_FLAGS="${LDFLAGS}" \
        -DCMAKE_CXX_FLAGS="${CXXFLAGS}" \
        -DCMAKE_CXX_FLAGS_RELEASE="${CXXFLAGS}" \
        -DCMAKE_CXX_FLAGS_DEBUG="${CXXFLAGS}" \

make externalLibs

EXTERNAL_LIB_FLAGS="-DWITH_QPBO=ON -DWITH_PLANARITY=ON -DWITH_BLOSSOM5=ON"

##
## Configure
##
cmake .. \
        -DCMAKE_C_COMPILER=${PREFIX}/bin/gcc \
        -DCMAKE_CXX_COMPILER=${PREFIX}/bin/g++ \
        -DCMAKE_INSTALL_PREFIX=${PREFIX} \
        -DCMAKE_PREFIX_PATH=${PREFIX} \
\
		-DCMAKE_SHARED_LINKER_FLAGS="${LDFLAGS}" \
        -DCMAKE_EXE_LINKER_FLAGS="${LDFLAGS}" \
        -DCMAKE_CXX_FLAGS="${CXXFLAGS}" \
        -DCMAKE_CXX_FLAGS_RELEASE="${CXXFLAGS}" \
        -DCMAKE_CXX_FLAGS_DEBUG="${CXXFLAGS}" \
        -DBUILD_PYTHON_WRAPPER=ON \
        -DBUILD_TESTING=OFF \
        -DBUILD_EXAMPLES=OFF \
        -DBUILD_COMMANDLINE=OFF \
\
        -DWITH_VIGRA=ON \
        -DWITH_BOOST=ON \
        -DWITH_HDF5=ON \
\
        ${EXTERNAL_LIB_FLAGS} \

##

##
## Compile
##
make -j${CPU_COUNT}

##
## Install to prefix
##
make install

# Install the external dylibs
mv src/external/libexternal-library-qpbo-shared.${DYLIB} "${PREFIX}/lib/"
mv src/external/libopengm-external-planarity-shared.${DYLIB} "${PREFIX}/lib/"
mv src/external/libopengm-external-blossom5-shared.${DYLIB} "${PREFIX}/lib/"
