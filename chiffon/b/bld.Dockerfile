FROM alpine:latest

# pass args at buildtime
# --build-arg USER=Jiminy
ARG USER=rta 
#ARG SSHD_CONFIG
#ARG AUTHORIZED_KEY
#ARG SSH_KEY_DIR
ARG CONTEXT

EXPOSE 22

RUN adduser $USER -D
# NOTE removing chpasswd breaks publickey ssh sign in
RUN echo $USER":124" | chpasswd
RUN echo  "root:124" | chpasswd


RUN apk add --no-cache sudo bash tmux sl 

# --------- Setup SSHD ---------
USER root
RUN apk add --no-cache openssh
RUN ssh-keygen -A
RUN echo "Welcome to SSH Lab!" >/etc/motd


#Clear and recreate sshd_config
RUN echo '#sshd_config' > /etc/ssh/sshd_config
RUN echo 'PasswordAuthentication no' >> /etc/ssh/sshd_config
RUN echo 'PermitRootLogin prohibit-password' >> /etc/ssh/sshd_config
RUN echo 'AllowTcpForwarding yes' >> /etc/ssh/sshd_config
RUN echo 'PermitTunnel yes' >> /etc/ssh/sshd_config

COPY ./$CONTEXT/ssh/ /home/$USER/.ssh/
#COPY $AUTHORIZED_KEY /home/$USER/.ssh/authorized_keys
RUN touch /home/$USER/.ssh/authorized_keys

RUN chown -R $USER:$USER /home/$USER/.ssh/
RUN chmod 700  /home/$USER/.ssh/*
RUN chmod 600  /home/$USER/.ssh/authorized_keys


# --------- login --------
USER root
WORKDIR /home/$USER
# Start sshd
# Moved sshd start to compose.yaml
#CMD ["/usr/sbin/sshd", "-D"]

#Allow ssh from a
COPY /a/ssh/id_ed25519.pub /home/$USER/.ssh/authorized_keys



