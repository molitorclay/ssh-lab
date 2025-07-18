#! /usr/bin/env bash
#Create ssh keys for lab

if [[ -z $1 ]]; then
	echo 'Usage: ./keygen.sh "ssh_a ssh_b ssh_c"'
fi

for i in $1; do
	mkdir -p $i/ssh
	ssh-keygen -t ed25519 -f $i/ssh/id_ed25519 -C "rta@"$i -N "" 
done
