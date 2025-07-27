# ==== Dockerfile =====
FROM alpine:latest AS ssh_base
# 'AS' may make building faster?

ARG USER=rta 
ARG SELF

# Expose does nothing
EXPOSE 22


RUN apk add --no-cache openssh file bash nano screen sl

# --------- Setup SSHD ---------
USER root
RUN ssh-keygen -A


#Clear and recreate sshd_config
RUN echo '# ==== sshd_config =====' > /etc/ssh/sshd_config
RUN echo 'PasswordAuthentication no' >> /etc/ssh/sshd_config
RUN echo 'PermitRootLogin no' >> /etc/ssh/sshd_config

FROM ssh_base


RUN adduser $USER -D
# NOTE removing chpasswd breaks publickey ssh sign in
RUN echo $USER":124" | chpasswd

RUN echo "Welcome to "$SELF"! Enjoy your stay." >/etc/motd

# Copy own key to .ssh
COPY ./$SELF/ssh/ /home/$USER/.ssh/
RUN touch /home/$USER/.ssh/authorized_keys

RUN chown -R $USER:$USER /home/$USER/.ssh/
RUN chmod 700  /home/$USER/.ssh/*
RUN chmod 600  /home/$USER/.ssh/authorized_keys


# ==== End of Dockerfile =====
