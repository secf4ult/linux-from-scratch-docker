#!/bin/bash
set -e

tar -xf gawk-*.tar.*
cd gawk-*/

sed -i 's/extras//' Makefile.in

./configure --prefix=/usr   \
            --host=$LFS_TGT \
            --build=$(build-aux/config.guess)

make
make DESTDIR=$LFS install