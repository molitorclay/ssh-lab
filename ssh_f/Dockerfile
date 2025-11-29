# ssh_f Dockerfile

# self ssh
COPY --chown=$USER:$USER $SELF/ssh/id_ed25519.pub /home/$USER/.ssh/authorized_keys
RUN chmod 600         /home/$USER/.ssh/authorized_keys

RUN echo 'PermitOpen none' >> /etc/ssh/sshd_config

