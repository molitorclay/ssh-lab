FROM alpine:3.21


# pass username at runtime
# --build-arg USER=Jiminy
ARG USER

#TODO add password
RUN adduser $USER -D
RUN echo $USER":124" | chpasswd
RUN echo  "root:124" | chpasswd


RUN apk add sudo bash tmux screen

# --------- Setup SSHD ---------
USER root
RUN apk add --update --no-cache openssh
RUN echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config
RUN echo 'PermitRootLogin prohibit-password' >> /etc/ssh/sshd_config
RUN ssh-keygen -A
#ENTRYPOINT ["/entrypoint.sh"]
EXPOSE 22
COPY ./ssh/id_ed25519.pub /home/$USER/.ssh/authorized_keys
COPY ./ssh/id_ed25519.pub  /home/root/.ssh/authorized_keys

RUN echo "Welcome to the SSH Lab!" >/etc/motd

# --------- login --------
#USER $USER
USER root
WORKDIR /home/$USER
CMD ["sh", "-c", "/usr/sbin/sshd -D & ; sh"]
