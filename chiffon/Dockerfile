# ==== Dockerfile =====
FROM alpine:latest AS ssh_base
# 'AS' may make building faster?

ARG USER=rta 
#ARG SSHD_CONFIG
#ARG AUTHORIZED_KEY
#ARG SSH_KEY_DIR
ARG SELF

EXPOSE 22

RUN adduser $USER -D
# NOTE removing chpasswd breaks publickey ssh sign in
RUN echo $USER":124" | chpasswd
#RUN echo  "root:124" | chpasswd


RUN apk add --no-cache sudo screen sl 

# --------- Setup SSHD ---------
USER root
RUN apk add --no-cache openssh
RUN ssh-keygen -A
RUN echo "Welcome to "$SELF"! Have a nice stay." >/etc/motd


#Clear and recreate sshd_config
RUN echo '# ==== sshd_config =====' > /etc/ssh/sshd_config
RUN echo 'PasswordAuthentication no' >> /etc/ssh/sshd_config
RUN echo 'PermitRootLogin prohibit-password' >> /etc/ssh/sshd_config
RUN echo 'Subsystem sftp internal-sftp' >> /etc/ssh/sshd_config


FROM ssh_base

COPY ./$SELF/ssh/ /home/$USER/.ssh/
RUN touch /home/$USER/.ssh/authorized_keys

RUN chown -R $USER:$USER /home/$USER/.ssh/
RUN chmod 700  /home/$USER/.ssh/*
RUN chmod 600  /home/$USER/.ssh/authorized_keys

# ==== End of Dockerfile =====
