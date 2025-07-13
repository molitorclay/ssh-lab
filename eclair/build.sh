#! /usr/bin/env bash
# Build, run, and commit 

git add *
echo "TEST: " $@
git commit -m "fixup! BUILD-TEST"  
docker build -t "ssh-lab" . "$@" && \
docker run --privileged -it --rm ssh-lab 


