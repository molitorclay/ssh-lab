FROM alpine:latest


# pass args at buildtime
# --build-arg USER=Jiminy
ARG USER
ARG SSHD_CONFIG
ARG AUTHORIZED_KEY
ARG PRIV_KEY

EXPOSE 22

#TODO add password
RUN adduser $USER -D
#RUN echo $USER":124" | chpasswd
#RUN echo  "root:124" | chpasswd


RUN apk add --no-cache sudo bash tmux 

# --------- Setup SSHD ---------
USER root
RUN apk add --no-cache openssh openrc
#RUN echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config
#RUN echo 'PermitRootLogin prohibit-password' >> /etc/ssh/sshd_config
RUN ssh-keygen -A
RUN echo "Welcome to SSH Lab!" >/etc/motd

COPY $SSHD_CONFIG /etc/ssh/sshd_config

COPY $AUTHORIZED_KEY /home/$USER/.ssh/authorized_keys
COPY $PRIV_KEY  /home/$USER/.ssh/
#RUN chown -R $USER /home/$USER/.ssh/*
RUN chown -R $USER:$USER /home/$USER/.ssh/
RUN chmod 700   /home/$USER/.ssh/*
RUN chmod 600   /home/$USER/.ssh/authorized_keys

# Allow self ssh for debugging
#COPY ./ssh/id_ed25519  /home/$USER/.ssh/id_ed25519

# --------- login --------
#USER $USER
USER root
WORKDIR /home/$USER
# Start sshd and allow Ctrl-C breaking
#CMD ["sh", "-c", "/usr/sbin/sshd -D; sh"]
#CMD ["/usr/sbin/sshd", "-D"]
RUN rc-service sshd start
