set +h
umask 022

export LFS=/mnt/lfs
export LC_ALL=POSIX
export LFS_TGT=$(uname -m)-lfs-linux-gnu
PATH=/usr/bin
if [ ! -L /bin ]; then PATH=/bin:$PATH; fi
export PATH=$LFS/tools/bin:$PATH
export CONFIG_SITE=$LFS/usr/share/config.site
export MAKEFLAGS=-j$(nproc)