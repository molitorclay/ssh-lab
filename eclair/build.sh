#! /usr/bin/env bash
# Build, run, and commit 
git add *

git commit -m "BUILD-TEST" 
sudo docker build -t "nix-ctf" . --build-arg RT_USER=jeff && \
sudo docker run -it --rm nix-ctf 


