# ssh_e Dockerfile

# self ssh
COPY --chown=$USER:$USER $SELF/ssh/id_ed25519.pub /home/$USER/.ssh/authorized_keys
RUN chmod 600         /home/$USER/.ssh/authorized_keys

RUN echo 'PermitOpen none' >> /etc/ssh/sshd_config

# Key for connecting to E, is password protected 
COPY ssh_e/ssh/id_ed25519 /home/$USER/E\'s_keys

#TODO generate and copy jpg with password

