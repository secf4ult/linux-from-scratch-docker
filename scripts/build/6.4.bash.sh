#!/bin/bash
set -e

tar -xf bash-*.tar.*
cd bash-*/

./configure --prefix=/usr                      \
            --build=$(sh support/config.guess) \
            --host=$LFS_TGT                    \
            --without-bash-malloc

make
make DESTDIR=$LFS install
ln -fs bash $LFS/bin/sh