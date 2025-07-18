# ssh_c Dockerfile

# Allow self and ssh_b to connect. B's key is on ssh_a
COPY ./$SELF/ssh/id_ed25519.pub temp1
COPY ./ssh_b/ssh/id_ed25519.pub temp2
RUN cat temp1 temp2 /home/$USER/.ssh/authorized_keys
RUN rm temp1 temp2
RUN chmod 600         /home/$USER/.ssh/authorized_keys
RUN chown $USER:$USER /home/$USER/.ssh/authorized_keys
