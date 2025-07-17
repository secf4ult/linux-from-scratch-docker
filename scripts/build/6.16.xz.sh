#!/bin/bash
set -e

tar -xf xz-*.tar.*
cd xz-*/

./configure --prefix=/usr                     \
            --host=$LFS_TGT                   \
            --build=$(build-aux/config.guess) \
            --disable-static                  \
            --docdir=/usr/share/doc/xz-5.6.4

make
make DESTDIR=$LFS install

rm -v $LFS/usr/lib/liblzma.la