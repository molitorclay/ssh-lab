
#self ssh
USER $USER
COPY ./$SELF/ssh/id_ed25519.pub /home/$USER/.ssh/authorized_keys
RUN chmod 600  /home/$USER/.ssh/authorized_keys


