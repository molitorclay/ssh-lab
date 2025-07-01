FROM alpine:3.21


# pass username at runtime
# --build-arg USER=Jiminy
ARG USER

#TODO add password 
RUN adduser $USER -D && \
    echo $USER":4597" | chpasswd



USER root
RUN apk add bash

# --------- login --------
USER $USER
WORKDIR /home/$USER
ENV USER=$USER
# Launch nix-shell instead of bash. RUN builds nix-shell for faster login
CMD /home/$USER/.nix-profile/bin/nix-shell 
#CMD ["bash"]

