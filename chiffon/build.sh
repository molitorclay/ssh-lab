#! /usr/bin/env bash
# Build, run, and commit 

# names of ssh images to build.
# There must be a directory for each name.

SSH_IMAGES=(ssh_a ssh_b ssh_c ssh_d ssh_e ssh_f)
SSH_IMAGES=(ssh_a ssh_b ssh_c ssh_d )

git add *
#git commit --fixup -m "BUILD-TEST"  
git commit -m "fixup! BUILD-TEST"  

#docker build -t "ssh-lab" . "$@" && \
#docker run -it --rm ssh-lab

# Create full docker files used by compose.yaml
# Make ssh keys
for i in $SSH_IMAGES
do
    cat Dockerfile $i/Dockerfile end.Dockerfile > $i/bld.Dockerfile
    echo "XXXXXXXXXXXXXXX " $i"/bld.Dockerfile"
    cat $i/bld.Dockerfile
    ssh-keygen -t ed25519 -f $i/ssh/id_ed25519 -C "rta@"$i -N "" <<< 'y' >/dev/null 
done

# Select random port for ssh_d
# Write selected port to ssh_d/port
# TODO use args instead of writing to file
PORTS=(7 9 13 37 53 88 106 113 119 135 139 179 199 389 427 465 548 554 587 631 646 873 990 993 995 1110 1433 1720 1723 1755 1900 2049 2121 2717 3000 3128 3306 3389 3986 4899 5000 5009 5051 5060 5101 5190 5357 5432 5631 5666 5800 5900 6646 7070 8000 8443 8888 9100 3276)

PORTS_LENGTH=${#PORTS[*]}
RAND=$(($RANDOM % $PORTS_LENGTH))
SSH_PORT=${PORTS[$RAND]}
echo $SSH_PORT > ssh_d/port
#TODO remove echo
echo "ssh_d port: "$SSH_PORT 




docker compose up --build
docker compose down
