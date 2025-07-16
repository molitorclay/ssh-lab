
#self ssh
COPY ./$SELF/ssh/id_ed25519.pub /home/$USER/.ssh/authorized_keys
RUN chmod 600         /home/$USER/.ssh/authorized_keys
RUN chown $USER:$USER /home/$USER/.ssh/authorized_keys


