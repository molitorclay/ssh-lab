#! /usr/bin/env bash
# Build, run, and commit 

# names of ssh images to build.
# There must be a directory for each name.

SSH_IMAGES="ssh_a ssh_b ssh_c ssh_d ssh_e ssh_f"
SSH_IMAGES="ssh_a ssh_b ssh_c" 

git add *
#git commit --fixup -m "BUILD-TEST"  
git commit -m "fixup! BUILD-TEST"  

#docker build -t "ssh-lab" . "$@" && \
#docker run -it --rm ssh-lab

# Create full docker files used by compose.yaml
for i in $SSH_IMAGES
do
	cat Dockerfile $i/Dockerfile end.Dockerfile > $i/bld.Dockerfile

done

docker compose up --build
docker compose down
