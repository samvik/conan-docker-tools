#!/usr/bin/env bash
sudo docker run -t -d --name conanclang50-x86 lasote/conanclang50-x86 && \
sudo docker exec conanclang50-x86 sudo pip install -U conan_package_tools && \
sudo docker exec conanclang50-x86 sudo pip install -U conan && \
sudo docker exec conanclang50-x86 conan user && \
sudo docker exec conanclang50-x86 conan install gtest/1.8.0@conan/stable -s arch=x86 -s compiler=clang -s compiler.version=5.0 -s compiler.libcxx=libstdc++ --build && \
sudo docker exec conanclang50-x86 conan install gtest/1.8.0@conan/stable -s arch=x86 -s compiler=clang -s compiler.version=5.0 -s compiler.libcxx=libc++ --build && \
sudo docker stop conanclang50-x86 && \
sudo docker rm conanclang50-x86
