#!/bin/bash
set -e

tar -xf gcc-*.tar.*
cd gcc-*/

tar -xf ../mpfr-*.tar.*
tar -xf ../gmp-*.tar.*
tar -xf ../mpc-*.tar.*
mv mpfr-* mpfr
mv gmp-* gmp
mv mpc-* mpc

sed -e '/m64=/s/lib64/lib/' -i.orig gcc/config/i386/t-linux64

mkdir build
cd build

../configure                  \
    --target=$LFS_TGT         \
    --prefix=$LFS/tools       \
    --with-glibc-version=2.41 \
    --with-sysroot=$LFS       \
    --with-newlib             \
    --without-headers         \
    --enable-default-pie      \
    --enable-default-ssp      \
    --disable-nls             \
    --disable-shared          \
    --disable-multilib        \
    --disable-threads         \
    --disable-libatomic       \
    --disable-libgomp         \
    --disable-libquadmath     \
    --disable-libssp          \
    --disable-libvtv          \
    --disable-libstdcxx       \
    --enable-languages=c,c++

make
make install

cd ..
cat gcc/limitx.h gcc/glimits.h gcc/limity.h > $(dirname $($LFS_TGT-gcc -print-libgcc-file-name))/include/limits.h