FROM alpine:latest

# pass args at buildtime
# --build-arg USER=Jiminy
ARG USER
#ARG SSHD_CONFIG
ARG AUTHORIZED_KEY
#ARG SSH_KEY_DIR

EXPOSE 22

RUN adduser $USER -D
# NOTE removing chpasswd disables publickey ssh sign in
RUN echo $USER":124" | chpasswd
RUN echo  "root:124" | chpasswd


RUN apk add --no-cache sudo bash tmux 

# --------- Setup SSHD ---------
USER root
RUN apk add --no-cache openssh
#RUN echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config
#RUN echo 'PermitRootLogin prohibit-password' >> /etc/ssh/sshd_config
RUN ssh-keygen -A
RUN echo "Welcome to SSH Lab!" >/etc/motd

#COPY $SSHD_CONFIG /etc/ssh/sshd_config
COPY ../sshd_config /etc/ssh/sshd_config

COPY ssh/            /home/$USER/.ssh/
COPY $AUTHORIZED_KEY /home/$USER/.ssh/authorized_keys
RUN chown -R $USER:$USER /home/$USER/.ssh/
RUN chmod 700  /home/$USER/.ssh/*
RUN chmod 600  /home/$USER/.ssh/authorized_keys

# Allow self ssh for debugging
#COPY ./ssh/id_ed25519  /home/$USER/.ssh/id_ed25519

# --------- login --------
#USER $USER
USER root
WORKDIR /home/$USER
# Start sshd and allow Ctrl-C breaking
#CMD ["sh", "-c", "/usr/sbin/sshd -D; sh"]
