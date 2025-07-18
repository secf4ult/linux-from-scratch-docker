#!/bin/bash
set -e

tar -xf m4-*.tar.*
cd m4-*/

./configure --prefix=/usr   \
            --host=$LFS_TGT \
            --build=$(build-aux/config.guess)
make
make DESTDIR=$LFS install