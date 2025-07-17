#!/bin/bash
set -e

tar -xf gzip-*.tar.*
cd gzip-*/

./configure --prefix=/usr --host=$LFS_TGT

make
make DESTDIR=$LFS install