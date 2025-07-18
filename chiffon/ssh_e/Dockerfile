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



