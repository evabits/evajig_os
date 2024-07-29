#!/bin/sh

export NIX_DISK_IMAGE=$(mktemp)
export QEMU_OPTS="-serial stdio"

truncate -s 1G $NIX_DISK_IMAGE
mkfs.ext4 -L nixos $NIX_DISK_IMAGE

./result/bin/*

rm -f $NIX_DISK_IMAGE