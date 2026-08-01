#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
apt-get -y install --no-install-recommends bind9 && \
rm -rf /var/lib/apt/lists/*
