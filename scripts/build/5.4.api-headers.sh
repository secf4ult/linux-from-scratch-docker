#!/bin/bash
set -e

tar -xf linux-*.tar.xz
cd linux-*/

make mrproper
make headers
find usr/include -type f ! -name '*.h' -delete
cp -r usr/include $LFS/usr