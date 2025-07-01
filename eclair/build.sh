#! /usr/bin/env bash
# Build, run, and commit 

git add *

git commit -m "BUILD-TEST" 
sudo docker build -t "ssh-lab" . --build-arg USER=$1 && \
sudo docker run -it --rm nix-ctf 


