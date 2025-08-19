# ==== end.Dockerfile ====

USER root

RUN echo '# === Low priority rules ===' >> /etc/ssh/sshd_config
RUN echo '# Allow forwarding and tunneling if not disabled above' >> /etc/ssh/sshd_config
RUN echo 'AllowTcpForwarding yes' >> /etc/ssh/sshd_config
RUN echo 'PermitTunnel yes' >> /etc/ssh/sshd_config
RUN echo 'Subsystem sftp internal-sftp' >> /etc/ssh/sshd_config

# Uninstall netcat
RUN rm -rf /usr/bin/nc

WORKDIR /home/$USER
# Start sshd
CMD ["/usr/sbin/sshd", "-D"]
