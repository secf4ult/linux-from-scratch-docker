#!/bin/bash
set -e

tar -xf tar-*.tar.*
cd tar-*/

./configure --prefix=/usr                     \
            --host=$LFS_TGT                   \
            --build=$(build-aux/config.guess)

make
make DESTDIR=$LFS install