#! /usr/bin/env bash
# Build, run, and commit 

# names of ssh images to build.
# There must be a directory for each image.

SSH_IMAGES="ssh_a ssh_b ssh_c ssh_d ssh_e ssh_f"
PORTS=(7 9 13 37 53 88 106 113 119 135 139 179 199 389 427 465 548 554 587 631 646 873 990 993 995 1110 1433 1720 1723 1755 1900 2049 2121 2717 3000 3128 3306 3389 3986 4899 5000 5009 5051 5060 5101 5190 5357 5432 5631 5666 5800 5900 6646 7070 8000 8443 8888 9100 3276)

git add *
git commit -m "fixup! BUILD-TEST"  

# --- Generate random port and password ---
# Write respective values to ssh_d/port and ssh_d/pass
# TODO use args instead of writing to file
PORTS_LENGTH=${#PORTS[*]}
RAND=$(($RANDOM % $PORTS_LENGTH))
SSH_PORT=${PORTS[$RAND]}

SSH_PASS=$(echo $RANDOM | shasum | head -c 4)
echo $SSH_PORT > ./ssh_d/port
echo $SSH_PASS > ./ssh_d/pass


# ---- Create full docker files used by compose.yaml ----
# Make ssh keys
for i in $SSH_IMAGES; do
    mkdir -p $i/ssh
    cat Dockerfile $i/Dockerfile end.Dockerfile > $i/bld.Dockerfile
    ssh-keygen -t ed25519 -f $i/ssh/id_ed25519 -C "rta@"$i -N "" <<< 'y' >/dev/null 
done
# overwrite ssh_d's key with a password protected key
ssh-keygen -t ed25519 -f ssh_d/ssh/id_ed25519 -C "rta@"$i -N $SSH_PASS <<< 'y' >/dev/null 

docker compose build
# Remove secrets
cp ssh_a/ssh/id_ed25519 a_key
for i in $SSH_IMAGES; do
#    rm $i/ssh/id_ed25519*
    echo "NOT REMOVING KEYS!!!"
done
rm ssh_d/port ssh_d/pass

docker compose up
docker compose down
