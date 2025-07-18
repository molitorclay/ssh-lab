# ssh_b Dockerfile


# self ssh.
COPY --chown=$USER:$USER ./$SELF/ssh/id_ed25519.pub /home/$USER/.ssh/authorized_keys
RUN chmod 600         /home/$USER/.ssh/authorized_keys

# Remove own key, the b key is present on A and is also used to connect to C
# Removing here to force the key located on A to be used.
RUN rm /home/$USER/.ssh/id_ed25519* 

