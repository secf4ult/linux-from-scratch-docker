FROM debian:12-slim

LABEL description="A docker image for Linux From Scratch"
LABEL version="0.1"
LABEL lfs_version="12.3"

ENV LFS=/mnt/lfs
ENV LC_ALL=POSIX
ENV LFS_TGT=x86_64-lfs-linux-gnu
ENV PATH=$LFS/tools:/usr/bin
ENV CONFIG_SITE=$LFS/usr/share/config.site

# prerequisite
WORKDIR /bin
RUN rm sh && ln -s bash sh
RUN apt update && apt install -y \
    build-essential              \
    bison                        \
    gawk                         \
    m4                           \
    python3                      \
    texinfo                      \
    wget

# file structure
RUN mkdir -pv $LFS/{etc,var,tools,sources,lib64} $LFS/usr/{bin,lib,sbin}
RUN for i in bin lib sbin; do ln -sv usr/$i $LFS/$i; done
RUN chmod -v a+wt $LFS/sources

# download packages
WORKDIR $LFS/sources
COPY scripts/wget-list-sysv.jp-mirror $LFS/sources
RUN wget --input-file=wget-list-sysv.jp-mirror \
         --continue --directory-prefix=$LFS/sources

