# ROOT_DCE is a DCE root folder where build and source directory are located
# Please change it with your own DCE root location (without / at the end)

ROOT_DCE=/home/fery/NS3Project/dce
./waf configure --prefix=$ROOT_DCE/build --enable-examples --enable-tests dir=$ROOT_DCE/source/ns-3.24
./waf dir=$ROOT_DCE/source/ns-3.24
./waf install dir=$ROOT_DCE/source/ns-3.24
