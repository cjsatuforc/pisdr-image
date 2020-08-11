#!/bin/bash -e

on_chroot << EOF
mkdir -p 	"/home/${FIRST_USER_NAME}/PiSDR/Software"
cd 		    "/home/${FIRST_USER_NAME}/PiSDR/Software"

if [ ! -d "volk" ]; then
    git clone --recursive https://github.com/gnuradio/volk.git
fi

cd volk
mkdir -p build
cd build
cmake -DCMAKE_BUILD_TYPE=Release ../
make -j$(nproc) install
ldconfig
EOF

on_chroot << EOF
mkdir -p 	"/home/${FIRST_USER_NAME}/PiSDR/Software"
cd 		    "/home/${FIRST_USER_NAME}/PiSDR/Software"

if [ ! -d "gnuradio" ]; then
    git clone --recursive https://github.com/gnuradio/gnuradio.git
fi

cd gnuradio
git checkout maint-3.7
mkdir -p build
cd build
cmake -DENABLE_INTERNAL_VOLK=OFF -DCMAKE_BUILD_TYPE=Release -DPYTHON_EXECUTABLE=/usr/bin/python ../
make -j$(nproc) install
ldconfig
EOF
