#!/bin/bash
set -e

cd gcc-*/libstdc++-*/

mkdir build
cd build

../configure                        \
    --host=$LFS_TGT                 \
    --build=$(../config.guess)      \
    --prefix=/usr                   \
    --disable-multilib              \
    --disable-nls                   \
    --disable-libstdcxx-pch         \
    --with-gxx-include-dir=/tools/$LFS_TGT/include/c++/14.2.0

make
make DESTDIR=$LFS install

rm $LFS/usr/lib64/lib{stdc++{,exp,fs},supc++}.la