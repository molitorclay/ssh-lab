# ==== end.Dockerfile ====
USER root
WORKDIR /home/$USER
# Start sshd
CMD ["/usr/sbin/sshd", "-D"]
