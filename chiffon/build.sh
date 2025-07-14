#! /usr/bin/env bash
# Build, run, and commit 

git add *
git commit --fixup -m "BUILD-TEST"  
#docker build -t "ssh-lab" . "$@" && \
#docker run -it --rm ssh-lab 
docker compose up

