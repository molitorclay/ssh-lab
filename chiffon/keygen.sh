#! /usr/bin/env bash
#Create ssh keys for lab

if [[ -z $1 ]]; then
	echo 'Usage: ./keygen.sh "a b c"'
fi
#NAMES="a b c d"

for i in $1; do
	mkdir -p $i/ssh
	ssh-keygen -t ed25519 -f $i/ssh/id_ed25519 -C "ssh_"$i -N "" 
done
