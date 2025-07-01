FROM alpine:3.21


# pass username at runtime
# --build-arg USER=Jiminy
ARG USER

#TODO add password 
RUN adduser $USER -D
RUN echo $USER":4597" | chpasswd



USER root
RUN apk add openssh
RUN apk add bash


RUN echo "Welcome to the SSH Lab!" >/etc/motd

# --------- login --------
USER $USER
WORKDIR /home/$USER
ENV USER=$USER
# Launch nix-shell instead of bash. RUN builds nix-shell for faster login
CMD ["bash"]

