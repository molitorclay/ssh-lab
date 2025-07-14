#! /usr/bin/env bash
#Create ssh keys for lab

NAMES="a b c d"

for i in $NAMES; do
	mkdir -p bld/$i/ssh
	ssh-keygen -t ed25519 -f ./bld/$i/ssh/id_ed25519 -C "ssh_"$i -N "" 
done
