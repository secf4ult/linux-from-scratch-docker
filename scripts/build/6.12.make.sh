#!/bin/bash
set -e

tar -xf make-*.tar.*
cd make-*/

./configure --prefix=/usr   \
            --without-guile \
            --host=$LFS_TGT \
            --build=$(build-aux/config.guess)

make
make DESTDIR=$LFS install