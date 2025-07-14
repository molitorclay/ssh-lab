#! /usr/bin/env bash
#Create ssh keys for lab

NAMES="a b c d"

for i in $NAMES; do
	mkdir -p $i/ssh
	ssh-keygen -t ed25519 -f $i/ssh/id_ed25519 -C "ssh_"$i -N "" 
done
