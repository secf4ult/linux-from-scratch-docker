#!/bin/bash
set -e

tar -xf diffutils-*.tar.*
cd diffutils-*/

./configure --prefix=/usr   \
            --host=$LFS_TGT \
            --build=$(./build-aux/config.guess)

make
make DESTDIR=$LFS install