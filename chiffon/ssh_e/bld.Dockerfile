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


RUN apk add --no-cache bash nano screen sl

# --------- Setup SSHD ---------
USER root
RUN apk add --no-cache openssh
RUN ssh-keygen -A
RUN echo "Welcome to "$SELF"! Enjoy your stay." >/etc/motd


#Clear and recreate sshd_config
RUN echo '# ==== sshd_config =====' > /etc/ssh/sshd_config
RUN echo 'PasswordAuthentication no' >> /etc/ssh/sshd_config
RUN echo 'PermitRootLogin no' >> /etc/ssh/sshd_config


FROM ssh_base

COPY ./$SELF/ssh/ /home/$USER/.ssh/
RUN touch /home/$USER/.ssh/authorized_keys

RUN chown -R $USER:$USER /home/$USER/.ssh/
RUN chmod 700  /home/$USER/.ssh/*
RUN chmod 600  /home/$USER/.ssh/authorized_keys

# ==== End of Dockerfile =====
# ssh_e Dockerfile

# Allow self and ssh_d
COPY $SELF/ssh/id_ed25519.pub temp1
COPY ./ssh_d/ssh/id_ed25519.pub temp2
RUN cat temp1 temp2 > /home/$USER/.ssh/authorized_keys
RUN rm temp1 temp2
RUN chmod 600         /home/$USER/.ssh/authorized_keys
RUN chown $USER:$USER /home/$USER/.ssh/authorized_keys

# Stop sshing in from other systems, must reverse ssh out
RUN echo 'PermitOpen none' >> /etc/ssh/sshd_config
RUN echo 'PermitListen *' >> /etc/ssh/sshd_config



# ==== end.Dockerfile ====

USER root

RUN echo '# === Low priority rules ===' >> /etc/ssh/sshd_config
RUN echo '# Allow forwarding and tunneling if not disabled above' >> /etc/ssh/sshd_config
RUN echo 'AllowTcpForwarding yes' >> /etc/ssh/sshd_config
RUN echo 'PermitTunnel yes' >> /etc/ssh/sshd_config
RUN echo 'Subsystem sftp internal-sftp' >> /etc/ssh/sshd_config


WORKDIR /home/$USER
# Start sshd
CMD ["/usr/sbin/sshd", "-D"]
