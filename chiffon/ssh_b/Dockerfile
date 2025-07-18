# ssh_b Dockerfile


# self ssh. Shared key with ssh_a to allow login
COPY --chown=$USER:$USER ./$SELF/ssh/id_ed25519.pub /home/$USER/.ssh/authorized_keys
RUN chmod 600         /home/$USER/.ssh/authorized_keys

