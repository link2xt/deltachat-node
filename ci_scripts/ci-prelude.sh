#!/bin/bash

# This script prepares the CI host by installing external dependencies
# for the deltachat-node bindings.

set -ex

# Some default variables, these are normally provided by the CI
# runtime.
DC_CORE_VERSION=${DC_CORE_VERSION:-master}

# To facilitate running locally, derive some Travis environment
# variables.
if [ -z "$TRAVIS_OS_NAME" ]; then
    case $(uname) in
        Darwin)
            TRAVIS_OS_NAME=osx
            ;;
        Linux)
            TRAVIS_OS_NAME=linux
            ;;
        *)
            echo "TRAVIS_OS_NAME unset and uname=$(uname) is unknown" >&2
            exit 1
    esac
fi

SYS_DC_CORE=${SYS_DC_CORE:-false}

# Install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs \
    | sh -s -- --default-toolchain nightly -y

# TODO fix builds against system installed rust-core
case $TRAVIS_OS_NAME in
    linux)
#        if [ "$SYS_DC_CORE" = "true" ]; then
#            git clone --branch=$DC_CORE_VERSION https://github.com/deltachat/deltachat-core deltachat-core-src
#            meson -Drpgp=true deltachat-core-build deltachat-core-src
#            ninja -v -C deltachat-core-build
#            ninja -v -C deltachat-core-build install
#            ldconfig -v
#            rm -rf deltachat-core-build deltachat-core-src
#        fi
        ;;
    osx)
#        if [ "$SYS_DC_CORE" = "true" ]; then
#            git clone --branch=$DC_CORE_VERSION https://github.com/deltachat/deltachat-core deltachat-core-src
#            meson -Drpgp=true deltachat-core-build deltachat-core-src
#            ninja -v -C deltachat-core-build
#            sudo ninja -v -C deltachat-core-build install
#        fi
#        rm -rf deltachat-core-build deltachat-core-src cyrus-sasl-*
        ;;
    *)
        echo "Unknown OS: $TRAVIS_OS_NAME" >&2
        exit 1
esac
