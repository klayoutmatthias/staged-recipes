#!/bin/bash

# even though we specify QMAKE_CXX in -expert mode, qmake still
# needs "g++" while obtaining gcc paths (while bootstrapping?)
# So we create a temporary link called "g++"
mkdir tmp_exe
cd tmp_exe
ln -s $GXX g++
cd ..
export PATH=$(pwd)/tmp_exe:$PATH 

# Unlike LDFLAGS, CXX etc., LIBS is not available as environment variable
# (needs a build.sh patch)
export LIBS=$($PYTHON -c "import sysconfig; print(sysconfig.get_config_var('LIBS'))")

"${SRC_DIR}"/build.sh -python ${PYTHON} -bin "${PREFIX}/bin" -expert -without-qtbinding
echo "bin Contents"
echo "--------------------"
ls "${PREFIX}/bin"
