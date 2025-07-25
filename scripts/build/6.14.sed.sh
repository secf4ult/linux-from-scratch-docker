#!/bin/bash
set -e

tar -xf sed-*.tar.*
cd sed-*/

./configure --prefix=/usr   \
            --host=$LFS_TGT \
            --build=$(./build-aux/config.guess)

make
make DESTDIR=$LFS install