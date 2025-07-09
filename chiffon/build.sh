#! /usr/bin/env bash
# Build, run, and commit 

git add *
echo "TEST: " "$@"
git commit -m "fixup! BUILD-TEST"  
sudo docker build -t "ssh-lab" . --build-arg "$@" && \
sudo docker run --privileged -it --rm ssh-lab 


