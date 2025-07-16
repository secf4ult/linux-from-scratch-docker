FROM debian:12-slim

LABEL description="A docker image for Linux From Scratch"
LABEL version="0.1"
LABEL lfs_version="12.3"

ENV LFS=/mnt/lfs
ENV LC_ALL=POSIX
ENV LFS_TGT=x86_64-lfs-linux-gnu
ENV PATH=$LFS/tools:/usr/bin:/usr/sbin
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
# clean up apt cache
RUN rm -rf /var/lib/apt/lists/*

# file structure
RUN mkdir -pv $LFS/{etc,var,tools,sources,lib64} $LFS/usr/{bin,lib,sbin}
RUN for i in bin lib sbin; do ln -sv usr/$i $LFS/$i; done
RUN chmod -v a+wt $LFS/sources

# download packages
WORKDIR $LFS/sources
COPY scripts/wget-list-sysv.jp-mirror .
RUN wget --input-file=wget-list-sysv.jp-mirror \
         --continue

# create user and group
RUN groupadd lfs && \
    useradd -s /bin/bash -g lfs -m -k /dev/null lfs && \
    echo "lfs:lfs" | chpasswd && \
    adduser lfs sudo
# manage permissions
RUN chown root:root $LFS/sources/*
RUN chown lfs $LFS/{usr,{,/*},var,etc,tools,lib64}

USER lfs
ENTRYPOINT [ "/bin/bash", "-l" ]