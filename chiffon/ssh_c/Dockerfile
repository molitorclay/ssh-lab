# ssh_c Dockerfile

# Allow self and ssh_b to connect. B's key is on ssh_a
COPY $SELF/ssh/id_ed25519.pub temp1
COPY ./ssh_b/ssh/id_ed25519.pub temp2
RUN cat temp1 temp2 > /home/$USER/.ssh/authorized_keys
RUN rm temp1 temp2
RUN chmod 600         /home/$USER/.ssh/authorized_keys
RUN chown $USER:$USER /home/$USER/.ssh/authorized_keys

# Remove the local copy of C's Key
# It can be downloaded from http_c
RUN cp /home/$USER/.ssh/id_ed25519 /home/$USER/httpc_debug #remove me 
RUN rm /home/$USER/.ssh/id_ed25519*
RUN echo "scp ~/.ssh/id_ed5519 root@http_c:~/" > /home/$USER/.ash_history
RUN echo "ssh http_c -i temp_key" > /home/$USER/.ash_history
RUN echo "rm ~/.ssh/id_ed5519*" > /home/$USER/.ash_history


