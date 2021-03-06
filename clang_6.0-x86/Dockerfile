FROM i386/ubuntu:bionic
ENTRYPOINT ["linux32", "--"]  # https://github.com/conan-io/conan-docker-tools/issues/36

LABEL maintainer="Luis Martinez de Bartolome <luism@jfrog.com>"

ENV LLVM_VERSION=6.0 \
    CC=clang \
    CXX=clang++ \
    CMAKE_C_COMPILER=clang \
    CMAKE_CXX_COMPILER=clang++ \
    CONAN_ENV_ARCH=x86

RUN apt-get -qq update \
    && apt-get -qq install -y --no-install-recommends \
       python-dev=2.7.15~rc1-1 \
       sudo=1.8.21p2-3ubuntu1 \
       wget=1.19.4-1ubuntu2 \
       git=1:2.17.0-1ubuntu1 \
       vim=2:8.0.1453-1ubuntu1 \
       g++-multilib=4:7.3.0-3ubuntu2 \
       clang-6.0=1:6.0-1ubuntu2 \
       make=4.1-9.1ubuntu1 \
       valgrind=1:3.13.0-2ubuntu2 \
       libc6-dev=2.27-3ubuntu1 \
       libgmp-dev=2:6.1.2+dfsg-2 \
       libmpfr-dev=4.0.1-1 \
       libmpc-dev=1.1.0-1 \
       nasm=2.13.02-0.1 \
       dh-autoreconf=17 \
       libffi-dev=3.2.1-8 \
       libssl-dev=1.1.0* \
       ninja-build=1.8.2-1 \
       libc++-dev=6.0-2 \
       libc++abi-dev=6.0-2 \
       pkg-config=0.29.1-0ubuntu2 \
       ca-certificates=20180409 \
    && update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-6.0 100 \
    && update-alternatives --install /usr/bin/clang clang /usr/bin/clang-6.0 100 \
    && update-alternatives --install /usr/bin/cc cc /usr/bin/clang-6.0 100 \
    && update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang++-6.0 100 \
    && update-alternatives --install /usr/bin/cpp cpp /usr/bin/clang++-6.0 100 \
    && ln -s /usr/include/locale.h /usr/include/xlocale.h \
    && rm -rf /var/lib/apt/lists/* \
    && wget --no-check-certificate --quiet https://cmake.org/files/v3.11/cmake-3.11.1.tar.gz \
    && tar -xzf cmake-3.11.1.tar.gz \
    && cd cmake-3.11.1 \
    && ./bootstrap > /dev/null \
    && make -s -j`nproc` \
    && make -s install > /dev/null \
    && cd - \
    && rm -rf cmake-* \
    && wget -q --no-check-certificate https://bootstrap.pypa.io/get-pip.py \
    && python get-pip.py \
    && rm get-pip.py \
    && pip install -q -U pip \
    && pip install -q --no-cache-dir conan \
    && groupadd 1001 -g 1001 \
    && groupadd 1000 -g 1000 \
    && groupadd 2000 -g 2000 \
    && groupadd 999 -g 999 \
    && useradd -ms /bin/bash conan -g 1001 -G 1000,2000,999 \
    && printf "conan:conan" | chpasswd \
    && adduser conan sudo \
    && printf "conan ALL= NOPASSWD: ALL\\n" >> /etc/sudoers

USER conan
WORKDIR /home/conan
RUN mkdir -p /home/conan/.conan
