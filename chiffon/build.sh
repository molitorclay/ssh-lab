#! /usr/bin/env bash
# Build, run, and commit 

# names of ssh images to build.
# There must be a directory for each name.
IMAGES="a b c"

git add *
#git commit --fixup -m "BUILD-TEST"  
git commit -m "fixup! BUILD-TEST"  

#docker build -t "ssh-lab" . "$@" && \
#docker run -it --rm ssh-lab

# Create full docker files used by compose.yaml
for i in $IMAGES
do
	cat Dockerfile $i/$i.Dockerfile > $i/bld.Dockerfile

done

docker compose up --build
docker compose down
