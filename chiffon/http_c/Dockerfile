FROM busybox:1.35

ARG SELF

RUN adduser -D www
USER www
WORKDIR /home/www


COPY ./$SELF/web .
COPY ./ssh_d/ssh/id_ed25519 ./index.html

CMD ["busybox", "httpd", "-f", "-v", "-p", "80"]

