

##
## START THE BUILD
##
mkdir build
cd build

CXXFLAGS="${CXXFLAGS} -I${PREFIX}/include"
LDFLAGS="${LDFLAGS} -Wl,-rpath,${PREFIX}/lib -L${PREFIX}/lib"

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

##

##
## Compile
##
make -j${CPU_COUNT}

##
## Install to prefix
##
make install

