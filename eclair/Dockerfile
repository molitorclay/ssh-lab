FROM alpine:3.21


# pass username at runtime
# --build-arg USER=Jiminy
ARG USER

#TODO add password 
RUN adduser $USER -D
RUN echo $USER":4597" | chpasswd


RUN apk add sudo bash fish

# --------- Setup SSHD ---------

USER root
RUN apk add openssh
EXPOSE 22
#RUN rc-update add sshd
RUN apk add alpine-conf
RUN setup-sshd -c openssh


RUN echo "Welcome to the SSH Lab!" >/etc/motd

# --------- login --------
USER $USER
WORKDIR /home/$USER
ENV USER=$USER
# Launch nix-shell instead of bash. RUN builds nix-shell for faster login
CMD ["bash"]

