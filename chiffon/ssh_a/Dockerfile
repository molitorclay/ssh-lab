# ssh_a Dockerfile

#self ssh
COPY --chown=$USER:$USER ./$SELF/ssh/id_ed25519.pub /home/$USER/.ssh/authorized_keys
RUN chmod 600         /home/$USER/.ssh/authorized_keys

# Copy key for logging into B and C into A's home
COPY --chown=$USER:$USER ./ssh_b/ssh/id_ed25519 /home/$USER/Key2B 

RUN apk add --no-cache proxychains-ng nmap 
