#! /usr/bin/env bash
# Build, run, and commit 

git add *

git commit -m "fixup! BUILD-TEST"  
sudo docker build -t "ssh-lab" . --build-arg USER=$1 && \
sudo docker run --privileged -it --rm ssh-lab 


